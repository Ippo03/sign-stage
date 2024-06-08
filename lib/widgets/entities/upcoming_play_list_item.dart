import 'package:flutter/material.dart';
import 'package:sign_stage/models/play.dart';

class UpcomingPlayListItem extends StatelessWidget {
  const UpcomingPlayListItem({
    super.key,
    required this.play,
  });

  final Play play;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Hall ${play.hall}: ${play.title} by ${play.author}'),
      subtitle: const Text('Starting 20-06-2024'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () {},
            child: const Text('Info'),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Book'),
          ),
        ],
      ),
    );
  }
}