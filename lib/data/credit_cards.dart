import 'package:sign_stage/models/util/credit_card.dart';

List<CreditCard> creditCards = [
  CreditCard(
    color: CreditCard.getRandomColor(),
    cardNumber: '1234 5678 9012 3456',
    expiryDate: '12/24',
    cardHolderName: 'Ippo',
    cvvCode: '123',
    cardType: CreditCard.getRandomCardType(),
  ),
  CreditCard(
    color: CreditCard.getRandomColor(),
    cardNumber: '2345 6789 0123 4567',
    expiryDate: '12/25',
    cardHolderName: 'Ippo',
    cvvCode: '234',
    cardType: CreditCard.getRandomCardType(),
  ),
];