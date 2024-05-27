import 'package:flutter/material.dart';

class SettingsListItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final Widget navigateTo;
  final Color textColor;

  const SettingsListItem({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.navigateTo,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(title, style: TextStyle(color: textColor)),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => navigateTo),
        );
      },
      
    );
  }
}
