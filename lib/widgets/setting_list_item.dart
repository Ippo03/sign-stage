import 'package:flutter/material.dart';

class SettingListItem extends StatelessWidget {
  const SettingListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Setting List Item'),
      subtitle: const Text('This is a setting list item.'),
      leading: const Icon(Icons.settings),
      onTap: () {
        // Add your code here
      },
    );
  }
}