import 'package:flutter/material.dart';
import 'package:sign_stage/models/play.dart';

class PlayDetails extends StatelessWidget {
  const PlayDetails({super.key, required this.play});

  final Play play;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Play Details'),
      ),
      body: Column(
        children: [
          Card(
            child: Text('Moby Dick'),
          ),
          Text("Duration"),
          Image.asset("assets/images/hotel-1.jpg"),
          Text("Description nnnnnnnnnnnnnnnnnnnnnnnn"),
          Text("Cast and production team"),
        ],
      ),
    );
  }
}
