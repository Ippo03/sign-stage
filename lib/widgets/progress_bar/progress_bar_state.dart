import 'package:flutter/material.dart';

class ProgressBarState extends ChangeNotifier {
  double _progress = 0.0;
  String _label = '';
  Color _color = Colors.blue; // Default color

  double get progress => _progress;
  String get label => _label;
  Color get color => _color;

  // Private constructor for singleton pattern
  ProgressBarState._();

  // Singleton instance
  static final ProgressBarState _instance = ProgressBarState._();

  // Factory constructor to provide access to the singleton instance
  factory ProgressBarState() => _instance;

  void updateProgress(double progress, String label, Color color) {
    _progress = progress;
    _label = label;
    _color = color;
    notifyListeners();
  }
}
