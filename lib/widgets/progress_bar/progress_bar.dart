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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildStep(Icons.info_outline, 1, currentStep, isFirst: true),
        _buildStep(Icons.date_range, 2, currentStep),
        _buildStep(Icons.airline_seat_recline_normal, 3, currentStep),
        _buildStep(Icons.credit_card, 4, currentStep, isLast: true),
      ],
    );
  }

  Widget _buildStep(IconData icon, int step, int currentStep, {bool isFirst = false, bool isLast = false}) {
    return Container(
      width: 50,
      height: 40,
      margin: const EdgeInsets.only(right: 4.0),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: _getBorderRadius(isFirst, isLast),
        color: _getColor(step, currentStep),
      ),
      child: Icon(
        icon,
        color: Colors.black,
        size: 35,
      ),
    );
  }

  BorderRadius _getBorderRadius(bool isFirst, bool isLast) {
    if (isFirst && isLast) {
      return BorderRadius.circular(20.0); 
    } else if (isFirst) {
      return const BorderRadius.horizontal(left: Radius.circular(20.0)); 
    } else if (isLast) {
      return const BorderRadius.horizontal(right: Radius.circular(20.0)); 
    } else {
      return BorderRadius.zero; 
    }
  }

  Color _getColor(int step, int currentStep) {
    if (currentStep >= step) {
      return currentStep == step ? Colors.yellow : Colors.green;
    } else {
      return Colors.grey;
    }
  }
}
