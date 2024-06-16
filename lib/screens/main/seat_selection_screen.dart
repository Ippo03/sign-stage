import 'package:flutter/material.dart';
import 'package:sign_stage/models/play.dart';
import 'package:sign_stage/screens/chat/base_screen.dart';
import 'package:sign_stage/screens/main/payment_screen.dart';
import 'package:sign_stage/widgets/progress_bar/progress_bar.dart';
import 'package:sign_stage/widgets/progress_bar/progress_bar_provider.dart';
import 'package:sign_stage/widgets/progress_bar/progress_bar_state.dart';

class SeatSelectionScreen extends StatefulWidget {
  const SeatSelectionScreen({
    super.key,
    required this.play,
  });

  final Play play;

  @override
  _SeatSelectionScreenState createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    final progressBarState = ProgressBarState();
    progressBarState.updateProgress(3);
    
    return BaseScreen(
      body: ProgressBarProvider(
        state: progressBarState,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Select your seat'),
          ),
          body: Column(
              children: [
                const ProgressBar(),
                const Text(
                  'Select your seat',
                ),
                ElevatedButton(
                  onPressed: () {
                    progressBarState.updateProgress(4);

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PaymentScreen(play: widget.play),
                      ),
                    );
                  },
                  child: const Text('Select'),
                ),
              ],
            ),
          ),
        ),
      );
  }
}
