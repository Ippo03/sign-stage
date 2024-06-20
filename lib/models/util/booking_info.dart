import 'package:intl/intl.dart';
import 'package:sign_stage/models/main/play.dart';

class BookingInfo {
  BookingInfo({
    required this.play,
    required this.selectedDate,
    required this.selectedTime,
    this.selectedSeats = const [],
    this.totalPrice = 0,
  });

  final Play play;
  final DateTime selectedDate;
  final String selectedTime;
  List<String> selectedSeats;
  int totalPrice;

  factory BookingInfo.fromJson(Map<String, dynamic> json) {
    return BookingInfo(
      play: Play.fromJson(json['play']),
      selectedDate: DateTime.parse(json['selectedDate']),
      selectedTime: json['selectedTime'],
      selectedSeats: List<String>.from(json['selectedSeats']),
      totalPrice: json['totalPrice'],
    );
  }

  // Getters
  String get fullDate {
    // Create DateFormat instances for weekday and month
    final DateFormat weekdayFormat = DateFormat('EEEE');
    final DateFormat monthFormat = DateFormat('MMM');

    // Get formatted weekday and month
    String weekday = weekdayFormat.format(selectedDate);
    String month = monthFormat.format(selectedDate);

    return '$weekday, ${selectedDate.day} $month ${selectedDate.year} -- $selectedTime';
  }

  void setSeats(List<String> selectedSeats) {
    this.selectedSeats = selectedSeats;
  }

  void setTotalPrice(int totalPrice) {
    this.totalPrice = totalPrice;
  }
}
