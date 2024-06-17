import 'package:barcode/barcode.dart';

class Ticket {
  final String id;
  final double price;
  final String date;
  final String time;
  final String location;
  final String status;
  final Barcode barcode;

  Ticket({
    required this.id,
    required this.price,
    required this.date,
    required this.time,
    required this.location,
    required this.status,
    required this.barcode,
  });
}