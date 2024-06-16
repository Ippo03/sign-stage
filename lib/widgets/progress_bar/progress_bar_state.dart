import 'package:flutter/material.dart';

class ProgressBarState extends ChangeNotifier {
  int _step = 1;
  Color _color = Colors.blue; 

  int get step => _step;

  Color get color => _color;

  // Private constructor for singleton pattern
  ProgressBarState._();

  // Singleton instance
  static final ProgressBarState _instance = ProgressBarState._();

  // Factory constructor to provide access to the singleton instance
  factory ProgressBarState() => _instance;

  void updateProgress(int step) {
    _step = step;
    notifyListeners();
  }
}
