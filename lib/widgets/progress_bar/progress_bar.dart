import 'package:flutter/material.dart';
import 'package:sign_stage/widgets/progress_bar/progress_bar_provider.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    final progressBarState = ProgressBarProvider.of(context)?.state;
    int currentStep = progressBarState?.step ?? 1;

    if (progressBarState == null) {
      throw FlutterError(
        'ProgressBar widget must be wrapped in a ProgressBarProvider widget.',
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildStep(Icons.theaters, 1, currentStep),
        _buildStep(Icons.calendar_today, 2, currentStep),
        _buildStep(Icons.access_time, 3, currentStep),
        _buildStep(Icons.payment, 4, currentStep),
      ],
    );
  }

  Widget _buildStep(IconData icon, int step, int currentStep) {
    return Icon(
      icon,
      color: currentStep >= step ? currentStep == step ? Colors.yellow : Colors.green : Colors.grey,
    );
  }
}