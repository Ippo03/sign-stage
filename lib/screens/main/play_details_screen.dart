import 'package:flutter/material.dart';
import 'package:sign_stage/models/main/play.dart';
import 'package:sign_stage/screens/chat/base_screen.dart';
import 'package:sign_stage/screens/main/booking_screen.dart';
import 'package:sign_stage/widgets/custom/custom_play_card.dart';
import 'package:sign_stage/widgets/progress_bar/progress_bar_state.dart';

class PlayDetailsScreen extends StatelessWidget {
  const PlayDetailsScreen({
    super.key,
    required this.play,
  });

  final Play play;

  @override
  Widget build(BuildContext context) {
    final progressBarState = ProgressBarState();

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
        body: Padding(
          padding: const EdgeInsets.all(0.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomPlayCard(play: play),
                Center(
                  child: Text(
                    'Duration: ${play.runtime} / Audience: ${play.ageLimit} years',
                    style: const TextStyle(fontSize: 18, color: Colors.yellow),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.asset(
                      play.imageUrl,
                      width: 400,
                      height: 225,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    play.description,
                    style: const TextStyle(
                        fontSize: 16, color: Colors.yellowAccent),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    play.additionalInfo,
                    style: const TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    'Cast and production team',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    play.cast.join(', '),
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    'Regular entry: ${play.regularTickets.price} €, Disabled people: ${play.specialNeedsTickets.price} €',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      progressBarState.updateProgress(2);

                      // Add your onPressed code here!
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => BookingScreen(play: play),
                        ),
                      );
                    },
                    child: const Text('Book tickets'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
