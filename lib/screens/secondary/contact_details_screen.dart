import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sign_stage/data/constants.dart';
import 'package:sign_stage/services/launcher_url_services.dart';
import 'package:sign_stage/widgets/custom/custom_map.dart';

class ContactDetailsScreen extends StatelessWidget {
  const ContactDetailsScreen({super.key});

  void _getDirections() {
    openGoogleMaps(
      signStageLat,
      signStageLng,
    );
  }

  void _makePhoneCall() {
    makePhoneCall(signStagePhone);
  }

  void _sendEmail() {
    sendEmail(signStageEmail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Contact Details',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey[800],
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
            const SizedBox(
              height: 150,
              child: CustomMap(
                markerLocation: LatLng(signStageLat, signStageLng),
                markerTitle: signStageName,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              signStageAddress,
              style: TextStyle(fontSize: 16.0, color: Colors.white),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _getDirections();
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
              ),
              child: const Text('Get Directions'),
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
            Row(
              children: [
                const SizedBox(width: 8.0),
                GestureDetector(
                  onTap: _makePhoneCall,
                  child: const Text(
                    signStagePhone,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
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
            Row(
              children: [
                const SizedBox(width: 8.0),
                GestureDetector(
                  onTap: _sendEmail,
                  child: const Text(
                    signStageEmail,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}