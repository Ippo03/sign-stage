import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sign_stage/models/main/user.dart';
import 'package:sign_stage/models/util/message.dart';
import 'package:sign_stage/screens/chat/navigation_message.dart';
import 'package:sign_stage/storage/message_store.dart';
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
  final List<Message> _messages = MessageStore().messages;
  final TextEditingController _controller = TextEditingController();
  bool _responseCompleted = false;
  late bool _showInitialMessage;
  final User user = User.instance!;
  Color _micIconColor = Colors.grey;
  final ScrollController _scrollController = ScrollController();

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
      _messages.add(Message(text: '', isReceived: true));
    });

    String initialMessage =
        """Hello! Welcome to Sign Stage Theater's AI assistant. I'm here to assist you with the following: 
  - Information about current and upcoming plays
  - Booking or canceling tickets
  - Viewing your purchased tickets
  - Directions and access to the theater
  - Learning more about Sign Stage Theater
  - Contacting a theater employee
  How can I help you today?""";
    _displayMessageCharacterByCharacter(initialMessage);
  }

  Future<void> _displayMessageCharacterByCharacter(String message) async {
    for (int i = 0; i < message.length; i++) {
      await Future.delayed(const Duration(milliseconds: 50));
      setState(() {
        _messages.last.text = message.substring(0, i + 1);
      });
      _scrollToBottom();
    }
    _speak(message);
  }

  void _speak(String message) {
    print('Speaking: $message');
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => _onSpeechStatus(val),
        onError: (val) => print('onError: $val'),
      );
      print('Available: $available');
      if (available) {
        setState(() {
          _isListening = true;
          _micIconColor =
              Colors.red; // Change mic icon color to red when listening
        });
        _speech.listen(
          onResult: (val) {
            setState(() {
              _text = val.recognizedWords;
              _controller.text = _text;
              _message = _text;
            });
          },
          cancelOnError: true,
        );
      } else {
        setState(() {
          _isListening = false;
          _micIconColor =
              Colors.grey; // Change mic icon color to grey when not listening
        });
        _speech.stop();
      }
    } else {
      setState(() {
        _isListening = false;
        _micIconColor = Colors.grey;
      });
      _speech.stop();
    }
  }

  void _onSpeechStatus(String status) {
    print('onStatus: $status');
    if (status == 'done' || status == 'notListening') {
      setState(() {
        _isListening = false;
        _micIconColor = Colors.grey;
      });
    }
  }

  Future<void> _sendMessage() async {
    setState(() {
      _messages.add(Message(text: _controller.text, isReceived: false));
      _message = _controller.text;
      _controller.clear();
      _responseCompleted = false;
      _isGeneratingResponse = true;
    });

    _scrollToBottom();

    // wait for a second before sending the message
    await Future.delayed(const Duration(seconds: 1));

    // Display typing indicator
    setState(() {
      _messages.add(Message(text: '', isReceived: true, isTyping: true));
    });

    _scrollToBottom();

    // Send message to server and fetch response
    final response = await http.post(
      Uri.parse('https://5575-104-155-207-37.ngrok-free.app/send_message'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'message': _message}),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      // Display the response character by character
      String responseText = responseData['response'];
      String responseCode = responseData['code'];

      List<String> parsedCode = parseCode(responseCode);
      responseCode = parsedCode[0];
      String responsePlay = parsedCode[1];

      print('Response: $responseText');
      print('Code: $responseCode');
      print('Play: $responsePlay');

      setState(() {
        _messages.removeLast(); // Remove typing indicator
      });

      bool canNavigate = canNavigateToScreen(responseCode, responsePlay);
      // canNavigate = false; // Always allow navigation for now
      String screen = mapCodeToScreen(responseCode, responsePlay);

      // add to the responseText a press the button below to navigate to the screen
      if (canNavigate) {
        responseText +=
            '\n\nPress the button below to continue to the ${screen.toLowerCase()} or keep chatting with me.';
      }

      print(('Code: $responseCode'));

      for (int i = 0; i < responseText.length; i++) {
        if (!_isGeneratingResponse) {
          break;
        }
        await Future.delayed(const Duration(milliseconds: 50));
        setState(() {
          if (i == 0) {
            // Start new message with first character
            _messages.add(Message(
                text: responseText.substring(0, i + 1), isReceived: true));
          } else {
            // Append next character to last message
            _messages.last.text = responseText.substring(0, i + 1);
            if (i == responseText.length - 1) {
              _responseCompleted = true;
              _isGeneratingResponse = false;

              // If navigation is possible, add the NavigationMessage widget
              if (canNavigate) {
                _messages.last = Message(
                  widget: NavigationMessage(
                      responseText: responseText, responseCode: responseCode),
                  isReceived: true,
                );
              }
            }
          }
        });
      }

      _scrollToBottom();

      _speak(responseText);
    } else {
      print('Failed to send message: ${response.body}');
      setState(() {
        _messages.removeLast();
      });
    }
  }

  void _scrollToBottom() {
    Future.delayed(Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  static String mapCodeToScreen(String code, String responsePlay) {
    switch (code) {
      case 'USER_WANTS_TO_GET_THEATER_INFO':
        return 'theater info';
      case 'USER_WANTS_TO_GET_DIRECTIONS':
        return 'theater info';
      case 'USER_WANTS_TO_CONTACT_A_HUMAN':
        return 'theater info';
      case 'USER_WANTS_TO_SUBMIT_A_COMPLAINT':
        return 'complaint form';
      case 'USER_CANCELS_TICKET':
        return 'your e-tickets';
      case 'USER_SEES_PURCHASED_TICKETS':
        return 'your e-tickets';
      case 'USER_CHOSE_THE_PLAY':
        return '"$responsePlay" booking form';
      case 'USER_WANTS_TO_GET_PLAY_INFO':
        return '"$responsePlay" info';
      default:
        return 'ChatScreen';
    }
  }

  static bool canNavigateToScreen(String code, String? responsePlay) {
    switch (code) {
      case 'USER_WANTS_TO_GET_PLAY_INFO':
        return responsePlay!.isNotEmpty; // check again
      case 'USER_WANTS_TO_GET_THEATER_INFO':
        return true;
      case 'USER_WANTS_TO_GET_DIRECTIONS':
        return true;
      case 'USER_WANTS_TO_CONTACT_A_HUMAN':
        return true;
      case 'USER_WANTS_TO_SUBMIT_A_COMPLAINT':
        return true;
      case 'USER_CANCELS_TICKET':
        return true;
      case 'USER_SEES_PURCHASED_TICKETS':
        return true;
      case 'USER_CHOSE_THE_PLAY':
        return true;
      case 'USER_INPUT_UNRELATED_TO_THEATER':
        return false; // has extra functionality
      case 'USER_INPUT_NOT_UNDERSTANDABLE':
        return false;
      case 'USER_CHOSE_INVALID_PLAY':
        return false;
      case 'OTHER':
        return false;
      default:
        return false;
    }
  }

  static List<String> parseCode(String responseCode) {
    List<String> results = [];
    bool isChosePlay = responseCode.startsWith('USER_CHOSE_THE_PLAY-');

    if (responseCode.startsWith('USER_CHOSE_THE_PLAY-') ||
        responseCode.startsWith('USER_WANTS_TO_GET_PLAY_INFO-')) {
      List<String> parts = responseCode.split('-');
      if (parts.length > 1) {
        String playName = parts[1];
        isChosePlay
            ? results.add('USER_CHOSE_THE_PLAY')
            : results.add('USER_WANTS_TO_GET_PLAY_INFO');
        results.add(playName);
      } else {
        results.add(responseCode);
        results.add('');
      }
    } else {
      results.add(responseCode);
      results.add('');
    }

    return results;
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
                const SizedBox(width: 4.0),
                const Text(
                  'Sign Stage Theater Assistant',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
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
                  final message = _messages[index];
                  return messageBubble(
                    isReceived: message.isReceived,
                    message: message.text,
                    widget: message.widget,
                    showVolumeIcon: index == _messages.length - 1
                        ? _responseCompleted
                        : false,
                    isTyping: message.isTyping ?? false,
                    showAssistantIcon: message.showAssistantIcon,
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
                    icon: Icon(_isListening ? Icons.mic : Icons.mic_none,
                        color: _micIconColor),
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

  Widget messageBubble({
    required bool isReceived,
    String? message,
    Widget? widget,
    required bool showVolumeIcon,
    required bool showAssistantIcon,
    bool isTyping = false,
  }) {
    bool isNavigationMessage = widget != null;

    return Row(
      mainAxisAlignment:
          isReceived ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment:
              isReceived ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: [
            if (isReceived && showAssistantIcon)
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
              padding: isNavigationMessage
                  ? EdgeInsets.zero
                  : const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: isReceived
                    ? isNavigationMessage
                        ? null
                        : Colors.white
                    : Colors.grey[400],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isTyping)
                    TypingIndicator()
                  else if (widget != null)
                    widget
                  else if (message != null)
                    Text(
                      message,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                    ),
                  if (isReceived && showVolumeIcon && message != null)
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
