import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_credit_card_ui/flutter_credit_card_ui.dart';
import 'package:sign_stage/models/main/user.dart';
import 'package:sign_stage/models/util/credit_card.dart';

class CustomCreditCard extends StatelessWidget {
  const CustomCreditCard({
    super.key,
    required this.index,
    required this.onCardSelected,
  });

  final int index;
  final Function(CreditCard) onCardSelected;

  @override
  Widget build(BuildContext context) {
    User? user = User.instance;

    if (user == null) {
      return const Center(child: Text('No user found'));
    }

    final creditCard = user.creditCards[index];

    return GestureDetector(
      onLongPress: () => onCardSelected(creditCard),
      child: CreditCardWidget(
        color: creditCard.color,
        cardHolder: creditCard.cardHolderName,
        cardNumber: creditCard.cardNumber,
        cardExpiration: creditCard.expiryDate,
        cvvText: creditCard.cvvCode,
        cardtype: creditCard.cardType,
      ),
    );
  }
}
