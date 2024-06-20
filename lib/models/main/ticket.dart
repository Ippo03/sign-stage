import 'package:barcode/barcode.dart';
import 'package:sign_stage/models/main/play.dart';
import 'package:sign_stage/models/util/booking_info.dart';

class Ticket {
  final String id;
  final Play play;
  final BookingInfo bookingInfo;
  final String status;
  final Barcode barcode;

  Ticket({
    required this.id,
    required this.play,
    required this.bookingInfo,
    required this.status,
    required this.barcode,
  });
}