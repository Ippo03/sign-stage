import 'package:flutter/material.dart';

class PlayDetails extends StatelessWidget {
  const PlayDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Play Details'),
      ),
      body: const Center(
        child: Text('This is the play details screen.'),
      ),
    );
  }
}