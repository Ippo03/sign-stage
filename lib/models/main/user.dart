import 'package:sign_stage/models/main/ticket.dart';
import 'package:sign_stage/models/util/credit_card.dart';

class User {
  // Private constructor
  User._privateConstructor({
    required this.username,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.imageUrl,
    required this.activities,
    required this.creditCards,
    required this.tickets,
  });

  // The single instance of the class
  static User? _instance;

  // Factory constructor to return the single instance
  factory User({
    required String username,
    required String email,
    required String password,
    required String phoneNumber,
    required String imageUrl,
    required List<String> activities,
    required List<CreditCard> creditCards,
    required List<Ticket> tickets,
  }) {
    _instance ??= User._privateConstructor(
      username: username,
      email: email,
      password: password,
      phoneNumber: phoneNumber,
      imageUrl: imageUrl,
      activities: activities,
      creditCards: creditCards,
      tickets: tickets,
    );
    return _instance!;
  }

  final String username;
  final String email;
  final String password;
  final String phoneNumber;
  final String imageUrl;
  final List<String> activities;
  final List<CreditCard> creditCards;
  final List<Ticket> tickets;

  // Get the instance
  static User? get instance => _instance;

  // Reset the instance (if needed)
  static void resetInstance() {
    _instance = null;
  }
}
