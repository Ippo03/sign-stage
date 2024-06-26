import 'package:flutter/material.dart';

class CustomInfoField extends StatelessWidget {
  const CustomInfoField({
    super.key,
    required this.infoText,
  });

  final String infoText;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(4.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          const Icon(
            Icons.info,
            color: Colors.white,
            size: 32,
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              infoText,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
