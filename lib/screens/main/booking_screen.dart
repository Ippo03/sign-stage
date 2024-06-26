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
          const SizedBox(height: 10.0),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.grey[600],
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
            selectedDate =
                DateTime(selectedDay.year, selectedDay.month, selectedDay.day);
          });
        },
        selectedDayPredicate: (day) {
          return isSameDay(selectedDate, day);
        },
        headerStyle: const HeaderStyle(
          titleCentered: true,
          formatButtonVisible: false,
          titleTextStyle: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white),
          rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white),
        ),
        calendarStyle: CalendarStyle(
          todayDecoration: BoxDecoration(
            // keep it like the others
            color: Colors.grey[600],
          ),
          selectedDecoration: BoxDecoration(
            color: Colors.blueAccent.withOpacity(0.5),
            shape: BoxShape.circle,
          ),
          selectedTextStyle:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          weekendTextStyle: const TextStyle(color: Colors.white),
          outsideTextStyle: const TextStyle(
              color: Colors.grey), // Grey color for days outside the month
          outsideDecoration: const BoxDecoration(
              color: Colors
                  .transparent), // Example: Transparent background for days outside the month
          defaultTextStyle: const TextStyle(color: Colors.white),
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

    final seatStatus =
        widget.play.ticketStatusForDateAndTime(selectedDate, timeOfDay);
    final hearingImpairedStatus = widget.play
        .hearingImpairedStatusForDateAndTime(selectedDate, timeOfDay);

    final seatColor = seatStatus == 'Available'
        ? Colors.green
        : seatStatus == 'Few Available'
            ? Colors.orange
            : Colors.red;

    final hearingImpairedColor =
        hearingImpairedStatus == false ? Colors.green : Colors.red;

    final soldOut = seatStatus == 'Sold Out';

    return InkWell(
      onTap: soldOut
          ? null // Disable onTap if sold out
          : () {
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
          color: soldOut ? Colors.grey : Colors.grey[100], // Grey if sold out
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  time,
                  style: TextStyle(fontSize: 20, color: Colors.grey[800]),
                ),
                Row(
                  children: [
                    Text(
                      'Seat status: $seatStatus',
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
                    widget.play.hearingImpaired
                        ? Text(
                            'Hearing impaired: ${hearingImpairedStatus ? 'Not Available' : 'Available'}',
                            style: TextStyle(color: Colors.grey[800]),
                          )
                        : const Text('No seats for hearing impaired people'),
                    const SizedBox(width: 10.0),
                    Container(
                      decoration: BoxDecoration(
                        color: hearingImpairedColor,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: widget.play.hearingImpaired
                          ? const Icon(
                              Icons.hearing,
                              color: Colors.white,
                              size: 16.0,
                            )
                          : const Icon(
                              Icons.hearing_disabled,
                              color: Colors.white,
                              size: 16.0,
                            ),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            soldOut
                ? const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                  )
                : Container(
                  padding: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                ),
          ],
        ),
      ),
    );
  }
}
