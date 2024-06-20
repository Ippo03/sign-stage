import 'package:flutter/material.dart';
import 'package:sign_stage/models/main/play.dart';
import 'package:sign_stage/models/util/booking_info.dart';
import 'package:sign_stage/screens/chat/base_screen.dart';
import 'package:sign_stage/screens/main/seat_selection_screen.dart';
import 'package:sign_stage/widgets/custom/custom_play_card.dart';
import 'package:sign_stage/widgets/progress_bar/progress_bar.dart';
import 'package:sign_stage/widgets/progress_bar/progress_bar_provider.dart';
import 'package:sign_stage/widgets/progress_bar/progress_bar_state.dart';
import 'package:table_calendar/table_calendar.dart';

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
                        progressBarState.updateProgress(1);
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
          body: SingleChildScrollView(
            child: Column(
              children: [
                CustomPlayCard(play: widget.play),
                _buildDateSelector(),
                _buildTimeSlots(progressBarState),
              ],
            ),
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
    return Container(
      height: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TableCalendar(
        focusedDay: widget.play.availableDates.entries.first.key,
        firstDay: widget.play.availableDates.entries.first.key,
        lastDay: widget.play.availableDates.entries.last.key,
        calendarFormat: CalendarFormat.month,
        onFormatChanged: (format) {
          // Handle format changes if needed
        },
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            print('Selected Date: $selectedDay');
            selectedDate = selectedDay;
          });
        },
        selectedDayPredicate: (day) {
          return isSameDay(selectedDate, day);
        },
        headerStyle: HeaderStyle(
          titleCentered: true,
          formatButtonVisible: false,
        ),
        calendarStyle: CalendarStyle(
          todayDecoration: BoxDecoration(
            color: Colors.blueAccent,
            shape: BoxShape.circle,
          ),
          selectedDecoration: BoxDecoration(
            color: Colors.blueAccent.withOpacity(0.5),
            shape: BoxShape.circle,
          ),
          selectedTextStyle: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildTimeSlots(ProgressBarState progressBarState) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          _buildTimeSlot(widget.play.afternoon, progressBarState),
          _buildTimeSlot(widget.play.night, progressBarState),
        ],
      ),
    );
  }

  Widget _buildTimeSlot(String time, ProgressBarState progressBarState) {
    final seatColor = widget.play.ticketStatusForDate(selectedDate) == 'available'
        ? Colors.green
        : Colors.red;
      
    final hearingStatus = widget.play.hearingImpaired ? 'Yes' : 'No';

    return InkWell(
      onTap: () {
        progressBarState.updateProgress(3);

        BookingInfo info = BookingInfo(
          play: widget.play,
          selectedDate: selectedDate,
          selectedTime: time,
        );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SeatSelectionScreen(
              play: widget.play,
              bookingInfo: info,
            ),
          ),
        );
      },
      child: Container(
        width: 325,
        padding: const EdgeInsets.all(12.0),
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              time,
              style: TextStyle(fontSize: 20, color: Colors.grey[800]),
            ),
            Text(
              'Seat status: ${widget.play.ticketStatusForDate(selectedDate)}',
              style: TextStyle(color: seatColor),
            ),
            Text(
              'Hearing impaired: $hearingStatus',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
