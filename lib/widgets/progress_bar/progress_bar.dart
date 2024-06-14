import 'package:flutter/material.dart';
import 'package:sign_stage/widgets/progress_bar/progress_bar_provider.dart';

class ProgressBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final progressBarState = ProgressBarProvider.of(context)?.state;

    if (progressBarState == null) {
      throw FlutterError(
        'ProgressBar widget must be wrapped in a ProgressBarProvider widget.',
      );
    }

    return SizedBox(
      width: double.infinity,
      height: 10.0,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progressBarState.progress,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(progressBarState.color),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: Text(
              progressBarState.label,
              style: const TextStyle(fontSize: 12.0, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
