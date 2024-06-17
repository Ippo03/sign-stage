import 'package:flutter/material.dart';
import 'package:sign_stage/models/play.dart';
import 'package:sign_stage/screens/main/booking_screen.dart';
import 'package:sign_stage/screens/main/play_details_screen.dart';
import 'package:sign_stage/widgets/progress_bar/progress_bar_state.dart';

class PlayListItem extends StatelessWidget {
  const PlayListItem({
    super.key,
    required this.play,
  });

  final Play play;

  @override
  Widget build(BuildContext context) {
    final progressBarState = ProgressBarState();
    
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Image.asset(play.imageUrl),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${play.hall}: ${play.title} by ${play.author}',
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
                  progressBarState.updateProgress(2);
                  
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
