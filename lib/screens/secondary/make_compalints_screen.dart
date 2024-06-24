import 'package:flutter/material.dart';
import 'package:sign_stage/data/complaints.dart';
import 'package:sign_stage/models/main/complaint.dart';
import 'package:sign_stage/models/main/user.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class MakeComplaintsScreen extends StatefulWidget {
  const MakeComplaintsScreen({super.key});

  @override
  State<MakeComplaintsScreen> createState() => _MakeComplaintsScreenState();
}

class _MakeComplaintsScreenState extends State<MakeComplaintsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _complaintDescriptionController = TextEditingController();
  final _otherHeadlineController = TextEditingController();
  String? _selectedComplaint;

  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;

  final user = User.instance;

  @override
  void dispose() {
    _complaintDescriptionController.dispose();
    _otherHeadlineController.dispose();
    super.dispose();
  }

  void _onAddComplaint() {
    if (_formKey.currentState!.validate()) {
      final complaint = Complaint(
        email: user!.email,
        phoneNumber: user!.phoneNumber,
        headline: _selectedComplaint == 'Other'
            ? _otherHeadlineController.text
            : _selectedComplaint ?? 'Other',
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

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => setState(() => _isListening = _speech.isListening),
        onError: (val) => setState(() => _isListening = false),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _complaintDescriptionController.text = val.recognizedWords;
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  String? _validateOtherHeadline(String? value) {
    if (_selectedComplaint == 'Other' && (value == null || value.isEmpty)) {
      return 'Please enter a headline for your complaint';
    }
    if (_selectedComplaint != 'Other' &&
        (_selectedComplaint == null || _selectedComplaint!.isEmpty)) {
      return 'Please select a complaint headline';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Make Complaint',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[800],
      ),
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
                  initialValue: user!.email,
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
                  readOnly: true,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  initialValue: user!.phoneNumber,
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
                  readOnly: true,
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
                DropdownButtonFormField<String>(
                  value: _selectedComplaint,
                  hint: const Text(
                    'Select a predefined complaint',
                    style: TextStyle(color: Colors.white),
                  ),
                  items: <String>[
                    'Poor audio quality',
                    'Uncomfortable seating',
                    'Late show start',
                    'Other'
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedComplaint = newValue;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Complaint Choices',
                    labelStyle: const TextStyle(color: Colors.white),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400]!),
                    ),
                  ),
                  dropdownColor: Colors.grey[850],
                ),
                if (_selectedComplaint == 'Other') ...[
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _otherHeadlineController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Enter your custom complaint headline...',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      labelText: 'Custom Complaint Headline',
                      labelStyle: const TextStyle(color: Colors.white),
                      border: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    validator: _validateOtherHeadline,
                  ),
                ],
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
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isListening ? Icons.mic : Icons.mic_none,
                        color: _isListening ? Colors.red : Colors.white,
                      ),
                      onPressed: _listen,
                    ),
                  ),
                ),
                const SizedBox(height: 24.0),
                Center(
                  child: ElevatedButton(
                    onPressed: _onAddComplaint,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.grey[700],
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
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
