import 'package:url_launcher/url_launcher.dart';

Future<void> openGoogleMaps(double latitude, double longitude) async {
  final googleMapsUrl = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');

  await canLaunchUrl(googleMapsUrl)
      ? await launchUrl(googleMapsUrl)
      : throw 'Could not launch $googleMapsUrl';
}

Future<void> makePhoneCall(String phoneNumber) async {
  final phoneCallUrl = Uri.parse('tel:$phoneNumber');

  await canLaunchUrl(phoneCallUrl)
      ? await launchUrl(phoneCallUrl)
      : throw 'Could not launch $phoneCallUrl';
}

Future<void> sendEmail(String email) async {
  final emailUrl = Uri.parse('mailto:$email');

  await canLaunchUrl(emailUrl)
      ? await launchUrl(emailUrl)
      : throw 'Could not launch $emailUrl';
}