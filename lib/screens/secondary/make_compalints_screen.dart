import 'package:flutter/material.dart';
import 'package:sign_stage/data/complaints.dart';
import 'package:sign_stage/models/main/complaint.dart';

class MakeComplaintsScreen extends StatefulWidget {
  const MakeComplaintsScreen({super.key});

  @override
  State<MakeComplaintsScreen> createState() => _MakeComplaintsScreenState();
}

class _MakeComplaintsScreenState extends State<MakeComplaintsScreen> {
  final _formKey = GlobalKey<FormState>();
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
    if (_formKey.currentState!.validate()) {
      final complaint = Complaint(
        email: _emailController.text,
        phoneNumber: _phoneNumberController.text,
        headline: _complaintHeadlineController.text,
        description: _complaintDescriptionController.text,
      );
      complaints.add(complaint);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Complaint submitted successfully!'),
        ),
      );

      Navigator.of(context).pop();
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    return null;
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    return null;
  }

  String? _validateComplaintHeadline(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a headline for your complaint';
    }
    return null;
  }

  String? _validateComplaintDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a description for your complaint';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Make Complaints',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey[800],
      ),
      backgroundColor: Colors.grey[800],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Your Contact Information:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _emailController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'johndoe@example.com',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    labelText: 'Your Email',
                    labelStyle: const TextStyle(color: Colors.white),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400]!),
                    ),
                  ),
                  validator: _validateEmail,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _phoneNumberController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: '6945678487',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    labelText: 'Phone Number',
                    labelStyle: const TextStyle(color: Colors.white),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400]!),
                    ),
                  ),
                  validator: _validatePhoneNumber,
                ),
                const SizedBox(height: 24.0),
                const Text(
                  'Complaint Details:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _complaintHeadlineController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Give a headline to your complaint...',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    labelText: 'Complaint Headline',
                    labelStyle: const TextStyle(color: Colors.white),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400]!),
                    ),
                  ),
                  validator: _validateComplaintHeadline,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _complaintDescriptionController,
                  style: const TextStyle(color: Colors.white),
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Explain your complaint in detail here...',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    labelText: 'Complaint Description',
                    labelStyle: const TextStyle(color: Colors.white),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400]!),
                    ),
                  ),
                  validator: _validateComplaintDescription,
                ),
                const SizedBox(height: 24.0),
                Center(
                  child: ElevatedButton(
                    onPressed: _onAddComplaint,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.grey[700],
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Submit Complaint',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}