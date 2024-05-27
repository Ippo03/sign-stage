import 'package:flutter/material.dart';

class PlayListItem extends StatelessWidget {
  const PlayListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Play List Item'),
      subtitle: const Text('This is a play list item.'),
      leading: const Icon(Icons.play_arrow),
      onTap: () {
      },
    );
  }
}
