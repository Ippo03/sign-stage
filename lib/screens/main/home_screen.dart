import 'package:flutter/material.dart';
import 'package:sign_stage/data/plays.dart';
import 'package:sign_stage/models/main/user.dart';
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
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0), 
          child: AppBar(
            backgroundColor: Colors.grey[800],
            automaticallyImplyLeading: false, 
          ),
        ),
        backgroundColor: Colors.grey[800],
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fitWidth, 
                  ),
                  Positioned(
                    top: 16.0,
                    left: 16.0,
                    child: IconButton(
                      icon: const Icon(Icons.settings),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SettingsScreen(),
                          ),
                        );
                      },
                      color: Colors.white,
                    ),
                  ),
                ],
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
