import 'package:flutter/material.dart';
import 'package:sign_stage/models/main/play.dart';
import 'package:sign_stage/models/main/user.dart';
import 'package:sign_stage/screens/main/etickets_screen.dart';
import 'package:sign_stage/widgets/custom/custom_credit_card.dart';
import 'package:sign_stage/widgets/custom/custom_text_field.dart';
import 'package:sign_stage/widgets/progress_bar/progress_bar.dart';
import 'package:sign_stage/widgets/progress_bar/progress_bar_provider.dart';
import 'package:sign_stage/widgets/progress_bar/progress_bar_state.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key, required this.play});

  final Play play;

  @override
  Widget build(BuildContext context) {
    final progressBarState = ProgressBarState();
    progressBarState.updateProgress(4);

    final user = User.instance;

    return ProgressBarProvider(
      state: progressBarState,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.grey[600],
          title: const Text('Checkout'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ProgressBar(),
              const SizedBox(height: 5),
              const Text(
                'Payment Method',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 260,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 10),
                  itemCount: user!.creditCards.length,
                  itemBuilder: (context, index) {
                    return CustomCreditCard(
                      index: index,
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Payment Details',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const CustomTextField(
                label: 'Your Email',
                hintText: 'johnDoe@example.com',
              ),
              const CustomTextField(
                label: 'Cardholder Name',
                hintText: 'John Doe',
              ),
              const CustomTextField(
                label: 'Card Number',
                hintText: '**** **** **** 51446',
              ),
              const Row(
                children: [
                  Expanded(
                      child: CustomTextField(
                    label: 'Expiration Date',
                    hintText: '02 Nov 2028',
                  )),
                  SizedBox(width: 10),
                  Expanded(
                      child: CustomTextField(
                    label: 'CVV',
                    hintText: '123',
                  )),
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Show success dialog and navigate to e-tickets screen
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ETicketsScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                  ),
                  child: Text(
                    'Pay Now  40 €',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
