import 'package:flutter/material.dart';

class MakeComplaints extends StatefulWidget {
  const MakeComplaints({super.key});

  @override
  State<MakeComplaints> createState() => _MakeComplaintsState();
}

class _MakeComplaintsState extends State<MakeComplaints> {
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
                // Handle submit complaint logic here
              },
              child: const Text('Submit your Complaint'),
            ),
          ],
        ),
      ),
    );
  }
}
