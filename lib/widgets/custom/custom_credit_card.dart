import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_credit_card_ui/flutter_credit_card_ui.dart';
import 'package:sign_stage/models/main/user.dart';

class CustomCreditCard extends StatelessWidget {
  const CustomCreditCard({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    User? user = User.instance;

    if (user == null) {
      return const Center(child: Text('No user found'));
    }

    return CreditCardWidget(
      color: user.creditCards[index].color,
      cardHolder: user.creditCards[index].cardHolderName,
      cardNumber: user.creditCards[index].cardNumber,
      cardExpiration: user.creditCards[index].expiryDate,
      cvvText: user.creditCards[index].cvvCode,
      cardtype: user.creditCards[index].cardType,
    );
  }
}
