import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double progress;
  final String label;
  final Color color;

  const ProgressBar({
    super.key,
    required this.progress,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 10.0,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: Text(
              label,
              style: TextStyle(fontSize: 12.0, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
