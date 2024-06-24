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
        backgroundColor: Colors.grey[800],
        appBar: AppBar(
          backgroundColor: Colors.grey[800],
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 8.0, 0, 0.0),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                progressBarState.updateProgress(1);
                Navigator.pop(context);
              },
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomPlayCard(play: play),
                const SizedBox(height: 5),
                Center(
                  child: Text(
                    'Duration: ${play.runtime} / Audience: ${play.ageLimit} years',
                    style: const TextStyle(fontSize: 18, color: Colors.yellow),
                    textAlign: TextAlign.center,
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
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 15),
                Center(
                  child: Text(
                    '** ${play.additionalInfo} **',
                    style: TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey[400],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    'Cast and Production Team',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    play.cast.join(', '),
                    style: TextStyle(fontSize: 16, color: Colors.grey[400]),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    'Regular Entry: ${play.regularTickets.price} €, Special Needs: ${play.specialNeedsTickets.price} €',
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Hearing Impaired: ',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      Icon(
                        play.hearingImpaired
                            ? Icons.hearing
                            : Icons.hearing_disabled,
                        color: play.hearingImpaired ? Colors.blue : Colors.red,
                        size: 24,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      progressBarState.updateProgress(2);

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => BookingScreen(play: play),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text(
                      'Book Tickets',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
