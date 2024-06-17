import 'package:flutter/material.dart';

class CustomSeatGrid extends StatelessWidget {
  final int rows;
  final int cols;
  final List<String> selectedSeats;
  final Function(String) onSeatSelected;

  const CustomSeatGrid({
    super.key,
    required this.rows,
    required this.cols,
    required this.selectedSeats,
    required this.onSeatSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Text(
            'Stage',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: cols,
            ),
            itemCount: rows * cols,
            itemBuilder: (context, index) {
              final row = index ~/ cols;
              final col = index % cols;
              final seat = '${String.fromCharCode(65 + row)}${col + 1}';
              final isSelected = selectedSeats.contains(seat);
              final isReserved = (index % 2 == 0); 
              final isAvailable = !isReserved && !isSelected;
              final isForHearingImpaired = (row < 2 && col < 2);

              return GestureDetector(
                onTap: isReserved
                    ? null
                    : () => onSeatSelected(seat),
                child: Container(
                  margin: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.green
                        : isReserved
                            ? Colors.red
                            : isAvailable
                                ? Colors.grey
                                : Colors.blue,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Center(
                    child: isForHearingImpaired
                        ? Icon(Icons.hearing, color: Colors.white)
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