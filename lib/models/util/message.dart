import 'package:flutter/material.dart';

class Message {
  String? text;
  final Widget? widget;
  final bool isReceived;
  final bool? isTyping;
  bool showAssistantIcon;

  Message({
    this.text,
    this.widget,
    required this.isReceived,
    this.isTyping,
    this.showAssistantIcon = true,
  });
}
