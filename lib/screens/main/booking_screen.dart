import 'package:flutter/material.dart';
import 'package:sign_stage/models/play.dart';
import 'package:sign_stage/screens/chat/base_screen.dart';
import 'package:sign_stage/screens/main/payment_screen.dart';
import 'package:sign_stage/widgets/custom/custom_progress_bar.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key, required this.play});

  final Play play;

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      body: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text(
            play.title,
            style: const TextStyle(
                fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ProgressBar(
                progress: 0.5,
                label: 'Seat Selection',
                color: Colors.blue,
              ),
              const SizedBox(height: 20.0),
              Text(
                'Hall ${play.hall}',
                style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10.0),
              Text(
                'Saturday, 8 June 2024, 17:30',
                style: TextStyle(fontSize: 14.0, color: Colors.grey),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Selected Seats:',
                    style: TextStyle(fontSize: 14.0, color: Colors.black),
                  ),
                  Text(
                    'TOTAL: 40 €',
                    style: TextStyle(fontSize: 14.0, color: Colors.black),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'C5, C6',
                    style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Image(
                image: AssetImage(
                    'assets/images/seat_map.png'), // Replace with your seat map image
                width: double.infinity,
                height: 150.0,
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Selected',
                    style: TextStyle(fontSize: 12.0, color: Colors.green),
                  ),
                  Text(
                    'Reserved',
                    style: TextStyle(fontSize: 12.0, color: Colors.grey),
                  ),
                  Text(
                    'Available',
                    style: TextStyle(fontSize: 12.0, color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // Handle checkout button press
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentScreen(play: play),
                    ),
                  );
                },
                child: const Text('Checkout'),
                // style: ElevatedButton.styleFrom(
                //   primary: Colors.blue,
                //   onPrimary: Colors.white,
                //   minimumSize: Size(double.infinity, 50.0),
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
