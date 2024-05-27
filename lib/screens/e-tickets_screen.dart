import 'package:flutter/material.dart';
import 'package:sign_stage/widgets/custom/detailed_column.dart';

class ETicketsScreen extends StatelessWidget {
  const ETicketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2D2D2D),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('E-Ticket'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Instruction',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Come to the theater, show your e-Ticket to the front entrance and let the staff scan the barcode.',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
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
                    child: Image.asset(
                      'assets/barcode.png', // Ensure you have a barcode image in your assets folder
                      height: 80,
                      width: 200,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                // style: ElevatedButton.styleFrom(
                //   primary: Colors.blue,
                //   padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                // ),
                child: Text(
                  'Download E-Ticket',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                // style: ElevatedButton.styleFrom(
                //   primary: Colors.red,
                //   padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                // ),
                child: Text(
                  'Cancel E-Ticket',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
