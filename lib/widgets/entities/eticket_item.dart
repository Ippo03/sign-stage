import "dart:math";

import "package:barcode/barcode.dart";
import "package:flutter/material.dart";
import "package:sign_stage/widgets/custom/custom_barcode_image.dart";
import "package:sign_stage/widgets/custom/custom_detailed_column.dart";

class ETicketItem extends StatelessWidget {
  const ETicketItem({
    super.key,
    // required this.ticket,
  });

  // final Ticket ticket;

  @override
  Widget build(BuildContext context) {
    final barcode = Barcode.code128();
    final randomData =
        List<int>.generate(10, (index) => Random().nextInt(10)).join();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Play: Moby Dick',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
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
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DetailedColumn(
              label: 'Date',
              value: '20/06/2024',
            ),
            DetailedColumn(
              label: 'Seats',
              value: 'C3, C4',
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DetailedColumn(
              label: 'Location',
              value: 'Hall A',
            ),
            DetailedColumn(
              label: 'Time',
              value: '17:30 PM',
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DetailedColumn(
              label: 'Payment',
              value: 'Successful',
            ),
            DetailedColumn(
              label: 'Order',
              value: '1904566',
            ),
          ],
        ),
        const SizedBox(height: 20),
        Center(
          child: CustomBarcodeImage(
            data: randomData,
            barcode: barcode,
          ),
        ),
      ],
    );
  }
}
