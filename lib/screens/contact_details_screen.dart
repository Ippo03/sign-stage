import 'package:flutter/material.dart';

class ContactDetailsScreen extends StatelessWidget {
  const ContactDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Details'),
      ),
      backgroundColor: Colors.grey[800],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Location',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8.0),
            Image.asset('assets/images/map.jpg'),
            const SizedBox(height: 16.0),
            const Text(
              'Pindakou 2, Athina 10671',
              style: TextStyle(fontSize: 16.0, color: Colors.white),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Get Directions'),
              // style: ElevatedButton.styleFrom(
              //   primary: Colors.blue, // Background color
              //   onPrimary: Colors.white, // Text color
              // ),
            ),
            const SizedBox(height: 16.0),
            const Row(
              children: [
                Icon(Icons.access_time, color: Colors.white),
                SizedBox(width: 8.0),
                Text(
                  'Working Hours',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Monday - Friday: 10:00 - 20:00\nSaturday: 10:00 - 14:00',
              style: TextStyle(fontSize: 16.0, color: Colors.white),
            ),
            const SizedBox(height: 16.0),
            const Row(
              children: [
                Icon(Icons.phone, color: Colors.white),
                SizedBox(width: 8.0),
                Text(
                  'Phone',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            const Text(
              '6970455215 (Tap this line)',
              style: TextStyle(fontSize: 16.0, color: Colors.white),
            ),
            const SizedBox(height: 16.0),
            const Row(
              children: [
                Icon(Icons.email, color: Colors.white),
                SizedBox(width: 8.0),
                Text(
                  'Email',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            const Text(
              'sign_stage@support.com',
              style: TextStyle(fontSize: 16.0, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
