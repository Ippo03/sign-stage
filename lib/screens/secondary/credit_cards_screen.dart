import 'package:flutter/material.dart';
import 'package:sign_stage/models/main/user.dart';
import 'package:sign_stage/widgets/custom/custom_credit_card.dart';

class CreditCardsScreen extends StatefulWidget {
  const CreditCardsScreen({Key? key}) : super(key: key);

  @override
  _CreditCardsScreenState createState() => _CreditCardsScreenState();
}

class _CreditCardsScreenState extends State<CreditCardsScreen> {
  User? user = User.instance;

  void _deleteCard(int index) {
    setState(() {
      user?.creditCards.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (user == null || user!.creditCards.isEmpty) {
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
        itemCount: user!.creditCards.length + 1,
        itemBuilder: (context, index) {
          if (index == user!.creditCards.length) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Add card action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Add Card',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            );
          }

          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomCreditCard(
                  index: index,
                  onCardSelected: (selectedCard) {},
                ),
              ),
              Positioned(
                top: 16,
                right: 16,
                child: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _deleteCard(index),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
