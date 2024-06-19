import 'package:flutter/material.dart';
import 'package:sign_stage/screens/main/login_screen.dart'; // Import your LoginScreen

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
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
      leading: Container(
        width: 40.0,
        height: 40.0,
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Icon(
          icon,
          color: iconColor,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontSize: 18.0,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: Colors.white,
      ),
      onTap: () {
        if (navigateTo.runtimeType == LoginScreen) {
          Navigator.of(context).popUntil((route) => route.isFirst); 
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => navigateTo),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => navigateTo),
          );
        }
      },
    );
  }
}
