import 'package:flutter/material.dart';
import 'package:sign_stage/widgets/custom/custom_seat_grid.dart';

class CustomSeatLayout extends StatelessWidget {
  final int rows;
  final int cols;
  final List<String> selectedSeats;
  final Function(String) onSeatSelected;

  const CustomSeatLayout({
    super.key,
    required this.rows,
    required this.cols,
    required this.selectedSeats,
    required this.onSeatSelected,
  });

  @override
  Widget build(BuildContext context) {
    return CustomSeatGrid(
      rows: rows,
      cols: cols,
      selectedSeats: selectedSeats,
      onSeatSelected: onSeatSelected,
    );
  }
}