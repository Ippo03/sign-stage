import 'package:flutter/material.dart';

class UpcomingPlayListItem extends StatelessWidget {
  const UpcomingPlayListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Upcoming Play List Item'),
      subtitle: const Text('This is an upcoming play list item.'),
      leading: const Icon(Icons.schedule),
      onTap: () {
      },
    );
  }
}