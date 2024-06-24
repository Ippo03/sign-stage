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
    Key? key,
    required this.play,
  }) : super(key: key);

  final Play play;

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  late DateTime selectedDate;
  late DateTime formattedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.play.availableDates.entries.first.key;
  }

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
    print('Available Dates ${widget.play.availableDates}');
    print('First Date ${widget.play.availableDates.entries.first.key}');
    print('Last Date ${widget.play.availableDates.entries.last.key}');
    return Container(
      height: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TableCalendar(
        focusedDay: selectedDate,
        firstDay: widget.play.availableDates.entries.first.key,
        lastDay: widget.play.availableDates.entries.last.key,
        calendarFormat: CalendarFormat.month,
        onFormatChanged: (format) {
          // Handle format changes if needed
        },
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            selectedDate = DateTime(selectedDay.year, selectedDay.month, selectedDay.day);
          });
        },
        selectedDayPredicate: (day) {
          return isSameDay(selectedDate, day);
        },
        headerStyle: const HeaderStyle(
          titleCentered: true,
          formatButtonVisible: false,
        ),
        calendarStyle: CalendarStyle(
          todayDecoration: const BoxDecoration(
            color: Colors.blueAccent,
            shape: BoxShape.circle,
          ),
          selectedDecoration: BoxDecoration(
            color: Colors.blueAccent.withOpacity(0.5),
            shape: BoxShape.circle,
          ),
          selectedTextStyle: const TextStyle(color: Colors.white),
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
    String timeOfDay = widget.play.afternoon == time ? 'afternoon' : 'night';
    final seatColor =
        widget.play.ticketStatusForDateAndTime(selectedDate, timeOfDay) ==
                'Available'
            ? Colors.green
            : widget.play.ticketStatusForDateAndTime(selectedDate, timeOfDay) ==
                    'Few Available'
                ? Colors.orange
                : Colors.red;

    final hearingImpairedColor = widget.play.hearingImpairedStatusForDateAndTime(selectedDate, timeOfDay) == false ? Colors.green : Colors.red;

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
            Row(
              children: [
                Text(
                  'Seat status: ${widget.play.ticketStatusForDateAndTime(selectedDate, timeOfDay)}',
                  style: TextStyle(color: Colors.grey[800]),
                ),
                const SizedBox(width: 10.0),
                Icon(
                  Icons.circle,
                  color: seatColor,
                  size: 16.0,
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Hearing impaired: ${widget.play.hearingImpairedStatusForDateAndTime(selectedDate, timeOfDay) == true ? 'Not Available' : 'Available'}',
                  style: TextStyle(color: Colors.grey[800]),
                ),
                const SizedBox(width: 10.0),
                Container(
                  decoration: BoxDecoration(
                    color: hearingImpairedColor,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: const Icon(
                    Icons.hearing,
                    color: Colors.white,
                    size: 16.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
