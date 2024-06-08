import 'package:flutter/material.dart';
import 'package:sign_stage/models/play.dart';
import 'package:sign_stage/screens/booking_screen.dart';
import 'package:sign_stage/screens/play_details_screen.dart';

class PlayListItem extends StatelessWidget {
  const PlayListItem({
    super.key,
    required this.play,
  });

  final Play play;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Image.network(play.imageUrl),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Hall ${play.hall}: ${play.title} by ${play.author}',
              style: const TextStyle(fontSize: 18),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PlayDetailsScreen(play: play),
                    ),
                  );
                },
                child: const Text('Info'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => BookingScreen(play: play),
                    ),
                  );
                },
                child: const Text('Book'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
