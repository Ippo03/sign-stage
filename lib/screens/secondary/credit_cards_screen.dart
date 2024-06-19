import 'package:flutter/material.dart';
import 'package:sign_stage/models/main/user.dart';
import 'package:sign_stage/widgets/custom/custom_credit_card.dart';

class CreditCardsScreen extends StatelessWidget {
  const CreditCardsScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    User? user = User.instance;

    if (user == null || user.creditCards.isEmpty) {
      return const Scaffold(
        body: Center(
          child: Text('No credit cards found'),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'My Credit Cards',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[800],
      ),
      body: ListView.builder(
        itemCount: user.creditCards.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(.0),
            child: CustomCreditCard(
                index: index,
                onCardSelected: (selectedCard) {},
              ),
          );
        },
      ),
    );
  }
}
