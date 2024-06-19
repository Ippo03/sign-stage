import 'package:flutter/material.dart';
import 'package:sign_stage/models/main/play.dart';
import 'package:sign_stage/screens/chat/base_screen.dart';
import 'package:sign_stage/screens/main/seat_selection_screen.dart';
import 'package:sign_stage/widgets/custom/custom_play_card.dart';
import 'package:sign_stage/widgets/progress_bar/progress_bar.dart';
import 'package:sign_stage/widgets/progress_bar/progress_bar_provider.dart';
import 'package:sign_stage/widgets/progress_bar/progress_bar_state.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({
    super.key,
    required this.play,
  });

  final Play play;

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime selectedDate = DateTime(2024, 6, 8);
  final List<DateTime> availableDates = [
    DateTime(2024, 6, 1),
    DateTime(2024, 6, 8),
    DateTime(2024, 6, 15),
  ];

  @override
  Widget build(BuildContext context) {
    final progressBarState = ProgressBarState();

    return BaseScreen(
      body: ProgressBarProvider(
        state: progressBarState,
        child: Scaffold(
          backgroundColor: Colors.grey[800],
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(10),
            child: AppBar(
              backgroundColor: Colors.grey[800],
              automaticallyImplyLeading: false,
            ),
          ),
          body: Column(
            children: [
              const ProgressBar(),
              CustomPlayCard(play: widget.play),
              _buildDateSelector(),
              _buildTimeSlots(progressBarState),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          _buildCalendar(),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    return CalendarDatePicker(
      initialDate: selectedDate,
      firstDate: DateTime(2024, 6, 1),
      lastDate: DateTime(2024, 6, 30),
      onDateChanged: (date) {
        setState(() {
          selectedDate = date;
        });
      },
      selectableDayPredicate: (date) {
        return availableDates.contains(date);
      },
    );
  }

  Widget _buildTimeSlots(ProgressBarState progressBarState) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          _buildTimeSlot('17:30', 'few available', 'available', Colors.orange,
              Colors.green, progressBarState),
          _buildTimeSlot('20:30', 'unavailable', 'unavailable', Colors.red,
              Colors.blue, progressBarState),
        ],
      ),
    );
  }

  Widget _buildTimeSlot(String time, String seatStatus, String hearingStatus,
      Color seatColor, Color hearingColor, ProgressBarState progressBarState) {
    return InkWell(
      onTap: () {
        progressBarState.updateProgress(3);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SeatSelectionScreen(
              play: widget.play,
            ),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12.0),
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(time,
                style: const TextStyle(fontSize: 20, color: Colors.white)),
            Text('Seat status: $seatStatus',
                style: TextStyle(color: seatColor)),
            Text('Hearing impaired: $hearingStatus',
                style: TextStyle(color: hearingColor)),
          ],
        ),
      ),
    );
  }
}
