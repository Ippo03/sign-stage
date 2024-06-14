import 'package:flutter/material.dart';
import 'package:sign_stage/data/plays.dart';
import 'package:sign_stage/models/user.dart';
import 'package:sign_stage/screens/chat/base_screen.dart';
import 'package:sign_stage/screens/secondary/settings_screen.dart';
import 'package:sign_stage/widgets/entities/play_list_item.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({
    super.key,
  });

  final User user = User.instance!;

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      body: Scaffold(
        appBar: AppBar(
          title: const Text('Sign Stage Theatre For All'),
          leading: IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsScreen(),
                ),
              );
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(
                'https://via.placeholder.com/150', // Replace with your logo URL
                height: 150,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Current plays',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              PlayListItem(
                play: plays[0],
              ),
              PlayListItem(
                play: plays[1],
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Upcoming plays',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              PlayListItem(
                play: plays[2],
              ),
              PlayListItem(
                play: plays[3],
              ),
              PlayListItem(
                play: plays[4],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
