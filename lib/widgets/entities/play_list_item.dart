import 'package:flutter/material.dart';
import 'package:sign_stage/models/main/play.dart';
import 'package:sign_stage/screens/main/booking_screen.dart';
import 'package:sign_stage/screens/main/play_details_screen.dart';
import 'package:sign_stage/widgets/progress_bar/progress_bar_state.dart';

class PlayListItem extends StatelessWidget {
  const PlayListItem({
    Key? key,
    required this.play,
  }) : super(key: key);

  final Play play;

  @override
  Widget build(BuildContext context) {
    final progressBarState = ProgressBarState();

    return Card(
      color: Colors.grey[850],
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: SizedBox(
                  height: 150,
                  width: double.infinity,
                  child: Image.asset(
                    play.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              if (play.hearingImpaired)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Icon(Icons.hearing, color: Colors.blue),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${play.hall}: ${play.title} by ${play.playwriter}',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PlayDetailsScreen(play: play),
                    ),
                  );
                },
                child: const Text('Info'),
              ),
              const SizedBox(width: 24.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                ),
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
          const SizedBox(height: 8.0),
        ],
      ),
    );
  }
}
