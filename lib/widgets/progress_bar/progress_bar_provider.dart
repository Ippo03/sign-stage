import 'package:flutter/material.dart';
import 'package:sign_stage/widgets/progress_bar/progress_bar_state.dart';

class ProgressBarProvider extends InheritedWidget {
  final ProgressBarState state;

  const ProgressBarProvider({
    super.key,
    required this.state,
    required super.child,
  });

  static ProgressBarProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ProgressBarProvider>();
  }

  @override
  bool updateShouldNotify(covariant ProgressBarProvider oldWidget) {
    return true; // Always notify listeners on state change
  }
}
