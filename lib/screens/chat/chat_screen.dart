import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sign_stage/models/main/user.dart';
import 'package:sign_stage/storage/message_store.dart';
import 'package:sign_stage/widgets/progress_bar/progress_bar.dart';
import 'package:sign_stage/widgets/progress_bar/progress_bar_provider.dart';
import 'package:sign_stage/widgets/progress_bar/progress_bar_state.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import 'typing_indicator.dart'; // Import the new typing indicator widget

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  bool _isGeneratingResponse = false;
  String _text = '';
  String _message = '';
  Offset offset = const Offset(20.0, 20.0);
  Offset initialPosition = Offset.zero;
  final List<Map<String, dynamic>> _messages = MessageStore().messages;
  final TextEditingController _controller = TextEditingController();
  bool _responseCompleted = false;
  late bool _showInitialMessage;
  final User user = User.instance!;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _showInitialMessage = _messages.isEmpty; 
    if (_showInitialMessage) {
      _initializeChat();
    }
  }

  void _initializeChat() {
    setState(() {
      _messages.add({'message': '', 'isReceived': true});
    });

    String initialMessage = "Hello, I'm your theater assistant! How can I help you?";
    _displayMessageCharacterByCharacter(initialMessage);
  }

  Future<void> _displayMessageCharacterByCharacter(String message) async {
    for (int i = 0; i < message.length; i++) {
      await Future.delayed(const Duration(milliseconds: 50));
      setState(() {
        _messages.last['message'] = message.substring(0, i + 1);
      });
    }
    _speak(message);
  }

  void _speak(String message) {
    print('Speaking: $message');
  }

  // void _speak(String text) async {
  //   await ttsInstance.setLanguage('en-US'); 

  //   await ttsInstance.setPitch(1.0); // Set pitch (1.0 is the default)
  //   await ttsInstance.speak(text); // Speak the provided text
  // }

  @override
  void dispose() {
    _timer?.cancel(); 
    super.dispose();
  }

  void _startTimeout() {
    // Cancel any previous timers before starting a new one
    _timer?.cancel();
    _timer = Timer(const Duration(seconds: 2), () {
      // Timeout reached, stop speech recognition
      if (_isListening) {
        _speech.stop();
        setState(() {
          _isListening = false;
        });
      }
    });
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      print('Available: $available');
      if (available) {
        setState(() {
          _isListening = true;
        });
        _startTimeout(); // Start timeout countdown
        _speech.listen(
          onResult: (val) {
            setState(() {
              _text = val.recognizedWords;
              _controller.text = _text;
              _message = _text;
            });
            _startTimeout(); // Reset timeout on each new result
          },
          cancelOnError: true,
        );
      } else {
        setState(() {
          _isListening = false;
        });
        _speech.stop();
      }
    } else {
      setState(() {
        _isListening = false;
      });
      _speech.stop();
    }
  }

  Future<void> _sendMessage() async {
    setState(() {
      _messages.add({'message': _controller.text, 'isReceived': false});
      _message = _controller.text;
      _controller.clear();
      _responseCompleted = false;
      _isGeneratingResponse = true;
    });

    // wait for a second before sending the message
    await Future.delayed(const Duration(seconds: 1));

    // Display typing indicator
    setState(() {
      _messages.add({'message': '', 'isReceived': true, 'isTyping': true});
    });

    // Send message to server and fetch response
    final response = await http.post(
      Uri.parse('http://192.168.2.61:5000/send_message'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'message': _message}),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      // Display the response character by character
      String responseText = responseData['response'];
      setState(() {
        _messages.removeLast(); 
        _messages.add({'message': '', 'isReceived': true});
      });
      for (int i = 0; i < responseText.length; i++) {
        if (!_isGeneratingResponse) {
          break;
        }
        await Future.delayed(const Duration(milliseconds: 50));
        setState(() {
          _messages.last['message'] = responseText.substring(0, i + 1);
          if (i == responseText.length - 1) {
            _responseCompleted = true;
            _isGeneratingResponse = false;
          }
        });
      }
      _speak(responseText);
    } else {
      print('Failed to send message: ${response.body}');
      setState(() {
        _messages.removeLast(); // Remove typing indicator
      });
    }
  }

  void _stopResponseGeneration() {
    setState(() {
      _isGeneratingResponse = false;
      _responseCompleted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final progressBarState = ProgressBarState();

    return ProgressBarProvider(
      state: progressBarState,
      child: Scaffold(
        backgroundColor: Colors.grey[800],
        appBar: AppBar(
          backgroundColor: Colors.grey[800],
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                const SizedBox(width: 20.0),
                const ProgressBar(),
              ],
            ),
          ),
        ),
        body: GestureDetector(
          onPanDown: (details) {
            initialPosition = details.localPosition;
          },
          onPanUpdate: (details) {
            setState(() {
              offset = Offset(
                offset.dx + details.delta.dx,
                offset.dy + details.delta.dy,
              );
            });
          },
          child: Stack(
            children: [
              chatContentWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget chatContentWidget() {
    return Positioned.fill(
      child: Material(
        color: Colors.grey[800],
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return messageBubble(
                    isReceived: _messages[index]['isReceived'],
                    message: _messages[index]['message'],
                    showIcon: index == _messages.length - 1
                        ? _responseCompleted
                        : false,
                    isTyping: _messages[index]['isTyping'] ?? false, // Check if the message is a typing indicator
                  );
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(_isListening ? Icons.mic : Icons.mic_none),
                    onPressed: _listen,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Type your message...',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10.0),
                      ),
                      onChanged: (text) {
                        setState(() {
                          _message = text;
                        });
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(_isGeneratingResponse ? Icons.stop : Icons.send),
                    onPressed: _isGeneratingResponse
                        ? _stopResponseGeneration
                        : _controller.text.isNotEmpty
                            ? _sendMessage
                            : null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget messageBubble(
      {required bool isReceived,
      required String message,
      required bool showIcon,
      bool isTyping = false}) {
    return Row(
      mainAxisAlignment:
          isReceived ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment:
              isReceived ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: [
            if (isReceived)
              Padding(
                padding: const EdgeInsets.only(bottom: 2.0, left: 4.0),
                child: Image.asset(
                  'assets/icons/assistant.png',
                  width: 40,
                  height: 40,
                ),
              ),
            if (!isReceived)
              Container(
                margin: const EdgeInsets.only(bottom: 2.0, right: 8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    user.imageUrl,
                    width: 40,
                    height: 40,
                  ),
                ),
              ),
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              margin:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: isReceived ? Colors.white : Colors.grey[400],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isTyping)
                    TypingIndicator() 
                  else
                    Text(
                      message,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                    ),
                  if (isReceived && showIcon)
                    IconButton(
                      icon: const Icon(Icons.volume_up),
                      onPressed: () {
                        _speak(message);
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
