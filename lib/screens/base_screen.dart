import 'package:flutter/material.dart';
import 'package:sign_stage/screens/chat_screen.dart';
import 'package:sign_stage/widgets/chatbot/chat_bubble.dart';

class BaseScreen extends StatefulWidget {
  final Widget body;

  const BaseScreen({super.key, required this.body});

  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  Offset _bubblePosition = Offset(0, 0);
  final double padding = 10.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _bubblePosition = Offset(
          MediaQuery.of(context).size.width -
              80 -
              padding, // Set the initial position with padding
          MediaQuery.of(context).size.height -
              80 -
              padding, // Set the initial position with padding
        );
      });
    });
  }

  void _onDragEnd(DraggableDetails details) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Get the position where the drag ended
    double dx = details.offset.dx;
    double dy = details.offset.dy;

    // Calculate the distances to the nearest edges
    double distanceToLeft = dx - padding;
    double distanceToRight = screenWidth - (dx + 60 + padding);
    double distanceToTop = dy - padding;
    double distanceToBottom = screenHeight - (dy + 60 + padding);

    // Find the nearest edge
    double minDistance = distanceToLeft;
    Offset newPosition = Offset(padding, dy);

    if (distanceToRight < minDistance) {
      minDistance = distanceToRight;
      newPosition = Offset(screenWidth - 60 - padding, dy);
    }
    if (distanceToTop < minDistance) {
      minDistance = distanceToTop;
      newPosition = Offset(dx, padding);
    }
    if (distanceToBottom < minDistance) {
      newPosition = Offset(dx, screenHeight - 60 - padding);
    }

    // Set the new position to the nearest edge
    setState(() {
      _bubblePosition = newPosition;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          widget.body,
          Positioned(
            left: _bubblePosition.dx,
            top: _bubblePosition.dy,
            child: Draggable(
              feedback: ChatBubble(
                isExpanded: true,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatScreen()),
                  );
                },
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
              childWhenDragging: Container(),
              child: ChatBubble(
                isExpanded: true,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatScreen()),
                  );
                },
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
              onDragEnd: _onDragEnd,
            ),
          ),
        ],
      ),
    );
  }
}
