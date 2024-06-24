import 'package:flutter/material.dart';

class Message {
  String? text;
  final Widget? widget;
  final bool isReceived;
  final bool? isTyping;

  Message({
    this.text,
    this.widget,
    required this.isReceived,
    this.isTyping,
  });
}
