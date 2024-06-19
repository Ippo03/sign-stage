import 'package:flutter/material.dart';

class CustomDrawerHeader extends StatelessWidget {
  final String imageUrl;
  final String username;
  final List<String> activities;

  const CustomDrawerHeader({
    super.key,
    required this.imageUrl,
    required this.username,
    required this.activities,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[800],
      padding: const EdgeInsets.fromLTRB(24, 16, 0, 0), 
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top), 
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: CircleAvatar(
              backgroundImage: AssetImage(imageUrl),
              radius: 26,
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  username,
                  style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  activities.join(', '),
                  style: const TextStyle(color: Colors.white, fontSize: 14, fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
