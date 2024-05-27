import 'package:flutter/material.dart';
import 'package:sign_stage/widgets/chatbot/chat_bubble.dart';
import 'package:sign_stage/widgets/custom/progress_bar.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String _message = '';
  Offset offset = Offset(20.0, 20.0);
  Offset initialPosition = Offset.zero;

  void _sendMessage() {
    print('Sending message: $_message');
    setState(() {
      _message = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: const ProgressBar(
          progress: 0.3, // Adjust progress value as needed
          label: '',
          color: Colors.blue,
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        onPanDown: (details) {
          // When the user starts dragging the screen
          // Save the initial position of the touch
          print('Dragging started');
          initialPosition = details.localPosition;
        },
        onPanUpdate: (details) {
          // When the user is dragging the screen
          // Update the position of the chat bubble
          setState(() {
            print('Dragging');
            print('dx: ${details.delta.dx}, dy: ${details.delta.dy}');
            offset = Offset(
              offset.dx + details.delta.dx,
              offset.dy + details.delta.dy,
            );
          });
        },
        onPanEnd: (details) {
          // When the user stops dragging the screen
          print('Dragging ended');
        },
        child: Stack(
          children: [
            chatContentWidget(),
            Positioned(
              left: offset.dx,
              top: offset.dy,
              child: ChatBubble(
                isExpanded: true,
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.lightBlue[300],
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(0.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.blueAccent,
                          width: 2.0), // Outline color and width
                      borderRadius: BorderRadius.circular(
                          30.0), // Optional: Make the border rounded
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 2.0, vertical: 2.0),
                      child: Image.asset(
                        'assets/icons/assistant.png',
                        width: 60.0,
                        height: 60.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
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
                reverse: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return messageBubble(
                      isReceived: true, message: 'Dummy message ${index + 1}');
                },
              ),
            ),
            Container(
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
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
                    icon: Icon(Icons.send),
                    onPressed: _message.isNotEmpty ? _sendMessage : null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget messageBubble({required bool isReceived, required String message}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: isReceived ? Colors.grey[200] : Colors.blue[100],
      ),
      child: Text(
        message,
        style: TextStyle(
          fontSize: 14.0,
          color: isReceived ? Colors.black : Colors.white,
        ),
      ),
    );
  }
}
