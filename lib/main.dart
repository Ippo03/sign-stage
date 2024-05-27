import 'package:flutter/material.dart';
import 'package:sign_stage/screens/chat_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Main App',
      home: const ChatScreen(),
    );
  }
}
