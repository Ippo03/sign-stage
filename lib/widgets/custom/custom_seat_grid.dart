import 'package:flutter/material.dart';
import 'package:sign_stage/models/main/play.dart';

class CustomSeatGrid extends StatelessWidget {
  final int rows;
  final int cols;
  final List<String> selectedSeats;
  final Function(String) onSeatSelected;
  final Play play;
  final DateTime selectedDate;
  final String selectedTime;

  const CustomSeatGrid({
    super.key,
    required this.rows,
    required this.cols,
    required this.selectedSeats,
    required this.onSeatSelected,
    required this.play,
    required this.selectedDate,
    required this.selectedTime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 50,
              height: 70,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 3.0),
                    child: Text(
                      'Interpreter',
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                    child: Center(
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/sign-language.png',
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Stage Container
            Container(
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.orange.shade500,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: const Center(
                child: Text(
                  'Stage',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 50,
              height: 70,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 3.0),
                    child: Text(
                      'Interpreter',
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                    child: Center(
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/sign-language.png',
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: cols,
            ),
            itemCount: rows * cols,
            itemBuilder: (context, index) {
              final timeOfDay =
                  selectedTime == play.afternoon ? 'afternoon' : 'night';
              final row = index ~/ cols;
              final col = index % cols;
              final seat = '${String.fromCharCode(65 + row)}${col + 1}';
              final isSelected = selectedSeats.contains(seat);
              final isReserved = play
                  .getReservedSeatsForDateAndTime(selectedDate, timeOfDay)
                  .contains(seat);
              // final isAvailable = !isReserved && !isSelected;
              final isForHearingImpaired = play.hearingImpaired
                  ? play.hall == 'Hall A'
                      ? (row < 2 && ((col < 1) || (col > cols - 2)))
                      : (row < 3 && ((col < 1) || (col > cols - 2)))
                  : false;

              return GestureDetector(
                onTap: isReserved ? null : () => onSeatSelected(seat),
                child: Container(
                  margin: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.green
                        : isReserved
                            ? Colors.red
                            : Colors.grey,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Center(
                    child: isForHearingImpaired
                        ? const Icon(Icons.hearing, color: Colors.white)
                        : Text(
                            seat,
                            style: const TextStyle(color: Colors.white),
                          ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
