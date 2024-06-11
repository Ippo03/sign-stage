import 'package:flutter/material.dart';
import 'package:sign_stage/models/play.dart';
import 'package:sign_stage/screens/main/booking_screen.dart';

class PlayDetailsScreen extends StatelessWidget {
  const PlayDetailsScreen({
    super.key,
    required this.play,
  });

  final Play play;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${play.title} Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.theaters, size: 40),
                  const SizedBox(width: 10),
                  Text(
                    'Hall A: ${play.title}',
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'by ${play.author}',
                style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 10),
              Text(
                'Duration: ${play.duration} / Audience: ${play.minAge} years +',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              Image.network(
                play.imageUrl,
                height: 200,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),
              Text(
                play.description,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                play.additionalInfo,
                style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 20),
              const Text(
                'Cast and production team',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                play.cast,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              Text(
                'Regular entry: ${play.regularPrice} €, Disabled people: ${play.discountedPrice} €',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Add your onPressed code here!
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => BookingScreen(play: play),
                      ),
                    );
                  },
                  child: const Text('Book tickets'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
