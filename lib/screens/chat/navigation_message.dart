import 'package:flutter/material.dart';
import 'package:sign_stage/screens/chat/navigation_mapper.dart';
import 'package:sign_stage/storage/message_store.dart';

class NavigationMessage extends StatelessWidget {
  final String responseCode;
  final String responseText;
  final String? responsePlayTitle;
  final bool isChatLocked;
  final VoidCallback? onResetChat;

  const NavigationMessage({
    Key? key,
    required this.responseCode,
    required this.responseText,
    this.responsePlayTitle,
    this.isChatLocked = false,
    this.onResetChat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.7,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 4.0),
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            responseText,
            style: const TextStyle(color: Colors.black, fontSize: 14.0),
          ),
          const SizedBox(height: 10.0),
          InkWell(
            onTap: () {
              print('Navigating to the appropriate screen...');
              print('Response title: $responsePlayTitle');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      mapResponseCodeToWidget(responseCode, responsePlayTitle)!,
                ),
              );
            },
            borderRadius: BorderRadius.circular(24.0),
            splashColor: Colors.blue.withOpacity(0.5),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(24.0),
              ),
              child: const Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Go to screen',
                      style: TextStyle(color: Colors.white, fontSize: 15.0),
                    ),
                    SizedBox(width: 8.0),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 15,
                    ),
                  ],
                ),
              ),
            ),
          ),
          isChatLocked
              ? Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Column(
                    children: [
                      const Text(
                        'or you can clear the chat to start a new chat by pressing the following button.',
                        style: TextStyle(color: Colors.black, fontSize: 14.0),
                      ),
                      const SizedBox(height: 10.0),
                      InkWell(
                        onTap: () {
                          // Clear the chat
                          print('Clearing the chat...');
                          // show an alert dialog to confirm the action
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Clear chat'),
                                content: const Text(
                                    'Are you sure you want to clear the chat?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('No'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      MessageStore().messages.clear();
                                      Navigator.pop(context);
                                      // reload the chat screen to reflect the changes
                                      MessageStore().chatRefreshedCount++;
                                      onResetChat!();
                                      // clear the chat
                                      print('Chat cleared!');
                                    },
                                    child: const Text('Yes'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        borderRadius: BorderRadius.circular(24.0),
                        splashColor: Colors.red.withOpacity(0.5),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 16.0),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                          child: const Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Clear chat',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15.0),
                                ),
                                SizedBox(width: 8.0),
                                Icon(
                                  Icons.refresh,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
