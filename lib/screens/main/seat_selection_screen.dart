import 'package:flutter/material.dart';
import 'package:sign_stage/models/main/play.dart';
import 'package:sign_stage/models/util/booking_info.dart';
import 'package:sign_stage/screens/chat/base_screen.dart';
import 'package:sign_stage/screens/main/payment_screen.dart';
import 'package:sign_stage/widgets/custom/custom_seat_layout.dart';
import 'package:sign_stage/widgets/progress_bar/progress_bar.dart';
import 'package:sign_stage/widgets/progress_bar/progress_bar_provider.dart';
import 'package:sign_stage/widgets/progress_bar/progress_bar_state.dart';

class SeatSelectionScreen extends StatefulWidget {
  const SeatSelectionScreen(
      {super.key, required this.play, required this.bookingInfo});

  final Play play;
  final BookingInfo bookingInfo;

  @override
  _SeatSelectionScreenState createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  List<String> selectedSeats = [];
  int total = 0;

  @override
  Widget build(BuildContext context) {
    final progressBarState = ProgressBarState();
    progressBarState.updateProgress(3);

    return BaseScreen(
      body: ProgressBarProvider(
        state: progressBarState,
        child: Scaffold(
          backgroundColor: Colors.grey[800],
          appBar: AppBar(
            backgroundColor: Colors.grey[800],
            elevation: 0,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
                    child: IconButton(
                      icon:
                          const Icon(Icons.arrow_back_ios, color: Colors.white),
                      onPressed: () {
                        progressBarState.updateProgress(2);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const SizedBox(width: 20.0),
                  const ProgressBar(),
                ],
              ),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.play.title,
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.bookingInfo.fullDate,
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Selected Seats: ${selectedSeats.isEmpty ? 'None' : selectedSeats.join(', ')}',
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Total: ${selectedSeats.length * widget.play.regularTickets.price} €',
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CustomSeatLayout(
                    rows: widget.play.hall == 'Hall A' ? 5 : 6,
                    cols: widget.play.hall == 'Hall A' ? 7 : 8,
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
                    play: widget.play,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: selectedSeats.isNotEmpty
                      ? () {
                          progressBarState.updateProgress(4);

                          widget.bookingInfo.setSeats(selectedSeats);
                          widget.bookingInfo.setTotalPrice(
                              selectedSeats.length *
                                  widget.play.regularTickets.price);

                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => PaymentScreen(
                                play: widget.play,
                                bookingInfo: widget.bookingInfo,
                              ),
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
