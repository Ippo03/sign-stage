import 'dart:math';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sign_stage/models/main/ticket.dart';
import 'package:sign_stage/widgets/custom/custom_barcode_image.dart';
import 'package:sign_stage/widgets/custom/custom_detailed_column.dart';

class ETicketItem extends StatelessWidget {
  const ETicketItem({
    super.key,
    required this.ticket,
  });

  final Ticket ticket;

  @override
  Widget build(BuildContext context) {
    final randomData =
        List<int>.generate(10, (index) => Random().nextInt(10)).join();

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Play: ${ticket.play.title}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'e-ticket',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DetailedColumn(
                    label: 'Date',
                    value: DateFormat('MM/dd/yyyy').format(ticket.bookingInfo.selectedDate),
                  ),
                  DetailedColumn(
                    label: 'Seats',
                    value: ticket.bookingInfo.selectedSeats.join(', '),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DetailedColumn(
                    label: 'Location',
                    value: ticket.play.hall,
                  ),
                  DetailedColumn(
                    label: 'Time',
                    value: '${ticket.bookingInfo.selectedTime} PM',
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DetailedColumn(
                    label: 'Payment',
                    value: ticket.status,
                  ),
                  DetailedColumn(
                    label: 'Price',
                    value: '${ticket.bookingInfo.totalPrice} €',
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const DottedLine(
                dashLength: 6.0,
                dashGapLength: 3.0,
                lineThickness: 1.0,
                dashColor: Colors.black,
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: CustomBarcodeImage(
              data: ticket.id.substring(0, 12),
              barcode: ticket.barcode,
            ),
          ),
        ),
      ],
    );
  }
}
