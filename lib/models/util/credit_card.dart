import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_credit_card_ui/flutter_credit_card_ui.dart';

class CreditCard {
  Color color;
  String cardNumber;
  String expiryDate;
  String cardHolderName;
  String cvvCode;
  CardType cardType;

  CreditCard({
    required this.color,
    this.cardNumber = '',
    this.expiryDate = '',
    this.cardHolderName = '',
    this.cvvCode = '',
    required this.cardType,
  });

  static Color getRandomColor() {
    final random = Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1,
    );
  }

  static CardType getRandomCardType() {
    final random = Random();
    const  values = CardType.values;
    return values[random.nextInt(values.length)];
  }
}