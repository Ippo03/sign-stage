import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sign_stage/storage/message_store.dart';
import 'package:sign_stage/widgets/progress_bar/progress_bar.dart';
import 'package:sign_stage/widgets/progress_bar/progress_bar_provider.dart';
import 'package:sign_stage/widgets/progress_bar/progress_bar_state.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = '';
  String _message = '';
  Offset offset = const Offset(20.0, 20.0);
  Offset initialPosition = Offset.zero;
  final List<Map<String, dynamic>> _messages = MessageStore().messages;
  final TextEditingController _controller = TextEditingController();
  bool _responseCompleted = false;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  Future<void> _speak(String message) async {
    print('Speaking: $message');
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      print('Available: $available');
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            _controller.text = _text;
            _message = _text;
          }),
        );
      } else {
        setState(() => _isListening = false);
        _speech.stop();
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  Future<void> _sendMessage() async {
    setState(() {
      _messages.add({'message': _controller.text, 'isReceived': false});
      _message = _controller.text;
      _controller.clear();
      _responseCompleted = false;
    });

    // sleep for half a second to simulate server response time
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _messages.add({'message': 'Waiting for your response...', 'isReceived': true});
    });

    // Send message to server and fetch response
    final response = await http.post(
      Uri.parse('http://192.168.250.61:5000/send_message'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'message': _message}),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      // Display the response character by character
      String responseText = responseData['response'];
      for (int i = 0; i < responseText.length; i++) {
        await Future.delayed(const Duration(milliseconds: 50));
        setState(() {
          _messages.last['message'] = responseText.substring(0, i + 1);
          if (i == responseText.length - 1) {
            _responseCompleted = true;
          }
        });
      }
      _speak(responseText);
    } else {
      print('Failed to send message: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final progressBarState = ProgressBarState();

    return ProgressBarProvider(
      state: progressBarState,
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: const ProgressBar(),
          centerTitle: true,
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
        color: Colors.white.withOpacity(0.3),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return messageBubble(
                    isReceived: _messages[index]['isReceived'],
                    message: _messages[index]['message'],
                    showIcon: index == _messages.length - 1 ? _responseCompleted : false,
                  );
                },
              ),
            ),
            Container(
              color: Colors.white,
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
                    icon: const Icon(Icons.send),
                    onPressed:
                        _controller.text.isNotEmpty ? _sendMessage : null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget messageBubble({required bool isReceived, required String message, required bool showIcon}) {
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
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Image.asset(
                  'assets/icons/assistant.png',
                  width: 40,
                  height: 40,
                ),
              ),
            if (!isReceived)
              Container(
                margin: const EdgeInsets.only(right: 8.0),
                child: const Icon(
                  Icons.account_circle,
                  size: 40,
                  color: Colors.blue,
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
                color: isReceived ? Colors.grey[200] : Colors.blue[100],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: isReceived ? Colors.black : Colors.white,
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
