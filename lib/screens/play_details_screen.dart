import 'package:flutter/material.dart';
import 'package:sign_stage/models/play.dart';
import 'package:sign_stage/screens/base_screen.dart';

class PlayDetailsScreen extends StatelessWidget {
  const PlayDetailsScreen({super.key, required this.play});

  final Play play;

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      body: Scaffold(
        appBar: AppBar(
          title: const Text('Play Details'),
        ),
        body: Column(
          children: [
            Card(
              child: Text(play.title),
            ),
            Text("Duration"),
            Image.asset("assets/images/hotel-1.jpg"),
            Text("Description nnnnnnnnnnnnnnnnnnnnnnnn"),
            Text("Cast and production team"),
          ],
        ),
      ),
    );
  }
}
