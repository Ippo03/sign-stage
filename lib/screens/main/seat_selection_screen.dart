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
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Card(
                      color: Colors.grey[900],
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Center(
                          child: Text(
                            '${widget.play.title} - ${widget.play.hall}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      color: Colors.grey[900],
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Center(
                          child: Text(
                            widget.bookingInfo.fullDate,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      color: Colors.grey[900],
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(
                              width: 4.0,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Selected Seats',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    selectedSeats.isEmpty
                                        ? 'Select your seats'
                                        : selectedSeats.join(', '),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              width: 2,
                              height: 50,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Total Price',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Total: ${selectedSeats.length * widget.play.regularTickets.price} €',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16),
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
                    selectedDate: widget.bookingInfo.selectedDate,
                    selectedTime: widget.bookingInfo.selectedTime,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        color: Colors.red,
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                      ),
                      const Text(
                        'Reserved',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        color: Colors.green,
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                      ),
                      const Text(
                        'Selected',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        color: Colors.grey,
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                      ),
                      const Text(
                        'Available',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ],
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
                    backgroundColor:
                        selectedSeats.isEmpty ? Colors.grey : Colors.blue,
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: const Text(
                    'Go to Checkout',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
