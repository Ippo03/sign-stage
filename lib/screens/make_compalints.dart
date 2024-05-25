import 'package:flutter/material.dart';

class MakeComplaints extends StatelessWidget {
  const MakeComplaints({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Make Complaints'),
      ),
      body: const Center(
        child: Text('This is the make complaints screen.'),
      ),
    );
  }
}