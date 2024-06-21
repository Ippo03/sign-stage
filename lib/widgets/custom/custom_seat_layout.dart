import 'package:flutter/material.dart';
import 'package:sign_stage/models/main/play.dart';
import 'package:sign_stage/widgets/custom/custom_seat_grid.dart';

class CustomSeatLayout extends StatelessWidget {
  final int rows;
  final int cols;
  final List<String> selectedSeats;
  final Function(String) onSeatSelected;
  final Play play;
  final DateTime selectedDate;
  final String selectedTime;

  const CustomSeatLayout({
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
    return CustomSeatGrid(
      rows: rows,
      cols: cols,
      selectedSeats: selectedSeats,
      onSeatSelected: onSeatSelected,
      play: play,
      selectedDate: selectedDate,
      selectedTime: selectedTime,
    );
  }
}