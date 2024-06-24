import 'package:sign_stage/data/credit_cards.dart';
import 'package:sign_stage/models/main/user.dart';

List<User> users = [
  User(
    username: 'ippo',
    email: 'ippo@example.com',
    password: 'ippo123',
    phoneNumber: '69891289347',
    imageUrl: 'assets/icons/profile_pic.png',
    activities: [
      'Play Hunter',
      'Theater Lover',
    ],
    creditCards: creditCards,
    tickets: [],
  ),
];
