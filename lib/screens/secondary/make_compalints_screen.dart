import 'package:flutter/material.dart';
import 'package:sign_stage/data/complaints.dart';
import 'package:sign_stage/models/complaint.dart';

class MakeComplaintsScreen extends StatefulWidget {
  const MakeComplaintsScreen({super.key});

  @override
  State<MakeComplaintsScreen> createState() => _MakeComplaintsScreenState();
}

class _MakeComplaintsScreenState extends State<MakeComplaintsScreen> {
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _complaintHeadlineController = TextEditingController();
  final _complaintDescriptionController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _phoneNumberController.dispose();
    _complaintHeadlineController.dispose();
    _complaintDescriptionController.dispose();
    super.dispose();
  }

  void _onAddComplaint() {
    final complaint = Complaint(
      email: _emailController.text,
      phoneNumber: _phoneNumberController.text,
      headline: _complaintHeadlineController.text,
      description: _complaintDescriptionController.text,
    );
    complaints.add(complaint);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Make Complaints'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Contact Information:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                hintText: 'john.doe@example.com',
                labelText: 'Your Email',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _phoneNumberController,
              decoration: const InputDecoration(
                hintText: '6970234123',
                labelText: 'Phone Number',
              ),
            ),
            const SizedBox(height: 24.0),
            const Text(
              'Complaint Details:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _complaintHeadlineController,
              decoration: const InputDecoration(
                hintText: 'Give a summary of the problem you are facing...',
                labelText: 'Complaint Headline',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _complaintDescriptionController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: 'Explain the problem in more detail...',
                labelText: 'Complaint Description',
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                _onAddComplaint();
              },
              child: const Text('Submit your Complaint'),
            ),
          ],
        ),
      ),
    );
  }
}
