import 'package:flutter/material.dart';
import 'package:sign_stage/models/play.dart';
import 'package:sign_stage/screens/chat/base_screen.dart';
import 'package:sign_stage/screens/main/payment_screen.dart';
import 'package:sign_stage/widgets/custom/custom_seat_layout.dart';
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
  List<String> selectedSeats = [];

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
            backgroundColor: Colors.blueGrey,
          ),
          body: Column(
            children: [
              const ProgressBar(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.play.title,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Hall A',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Saturday, 8 June 2024, 17:30',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Selected Seats: ${selectedSeats.join(', ')}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'TOTAL: ${selectedSeats.length * 20} €',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: CustomSeatLayout(
                  rows: 6,
                  cols: 8,
                  selectedSeats: selectedSeats,
                  onSeatSelected: (String seat) {
                    setState(() {
                      if (selectedSeats.contains(seat)) {
                        selectedSeats.remove(seat);
                      } else {
                        selectedSeats.add(seat);
                      }
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: selectedSeats.isNotEmpty
                      ? () {
                          progressBarState.updateProgress(4);

                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  PaymentScreen(play: widget.play),
                            ),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: const Text('Go to Checkout'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

