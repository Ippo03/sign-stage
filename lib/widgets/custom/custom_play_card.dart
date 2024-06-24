import 'package:flutter/material.dart';
import 'package:sign_stage/models/main/play.dart';

class CustomPlayCard extends StatelessWidget {
  const CustomPlayCard({
    super.key,
    required this.play,
  });

  final Play play;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          color: const Color(0xFFD9D9D9), 
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0), 
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center, 
              children: [
                const Icon(Icons.theaters, size: 40), 
                const SizedBox(width: 16.0), 
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start, 
                  children: [
                    Text(
                      '${play.hall}: ${play.title}',
                      style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      'by ${play.author}',
                      style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
