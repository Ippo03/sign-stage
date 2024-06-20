import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';
import 'package:sign_stage/models/main/play.dart';
import 'package:sign_stage/models/main/ticket.dart';
import 'package:sign_stage/models/main/user.dart';
import 'package:sign_stage/models/util/booking_info.dart';
import 'package:sign_stage/models/util/credit_card.dart';
import 'package:sign_stage/widgets/custom/custom_credit_card.dart';
import 'package:sign_stage/widgets/custom/custom_pop_up.dart';
import 'package:sign_stage/widgets/custom/custom_text_field.dart';
import 'package:sign_stage/widgets/progress_bar/progress_bar.dart';
import 'package:sign_stage/widgets/progress_bar/progress_bar_provider.dart';
import 'package:sign_stage/widgets/progress_bar/progress_bar_state.dart';
import 'package:uuid/uuid.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({
    super.key,
    required this.play,
    required this.bookingInfo,
  });

  final Play play;
  final BookingInfo bookingInfo;

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final progressBarState = ProgressBarState();
  final user = User.instance;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController cardholderNameController =
      TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expirationDateController =
      TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  @override
  void initState() {
    super.initState();
    progressBarState.updateProgress(4);
  }

  @override
  void dispose() {
    emailController.dispose();
    cardholderNameController.dispose();
    cardNumberController.dispose();
    expirationDateController.dispose();
    cvvController.dispose();
    super.dispose();
  }

  void _onCardSelected(CreditCard card) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Card Selected'),
          content: const Text(
              'Do you want to fill the payment details with this card?'),
          actions: [
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                setState(() {
                  emailController.text = user!.email;
                  cardholderNameController.text = card.cardHolderName;
                  cardNumberController.text = card.cardNumber;
                  expirationDateController.text = card.expiryDate;
                  cvvController.text = card.cvvCode;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  bool _validateFields() {
    return emailController.text.isNotEmpty &&
        cardholderNameController.text.isNotEmpty &&
        cardNumberController.text.isNotEmpty &&
        expirationDateController.text.isNotEmpty &&
        cvvController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return ProgressBarProvider(
      state: progressBarState,
      child: Scaffold(
        backgroundColor: Colors.grey[800],
        appBar: AppBar(
          backgroundColor: Colors.grey[800],
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: () {
                      progressBarState.updateProgress(3);
                      Navigator.pop(context);
                    },
                  ),
                ),
                const SizedBox(width: 20.0),
                const ProgressBar(),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Payment Method',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
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
                        onCardSelected: _onCardSelected,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Payment Details',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                CustomTextField(
                  label: 'Your Email',
                  controller: emailController,
                  hintText: 'johnDoe@example.com',
                ),
                CustomTextField(
                  label: 'Cardholder Name',
                  controller: cardholderNameController,
                  hintText: 'John Doe',
                ),
                CustomTextField(
                  label: 'Card Number',
                  controller: cardNumberController,
                  hintText: '**** **** **** 51446',
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        label: 'Expiration Date',
                        controller: expirationDateController,
                        hintText: '02 Nov 2028',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomTextField(
                        label: 'CVV',
                        controller: cvvController,
                        hintText: '123',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: _validateFields()
                        ? () {
                            setState(() {
                              progressBarState.updateProgress(5);
                            });

                            Ticket ticket = Ticket(
                              id: const Uuid().v4(),
                              play: widget.play,
                              bookingInfo: widget.bookingInfo,
                              status: 'Successful',
                              barcode: Barcode.code128(),
                            );

                            user!.tickets.add(ticket);

                            // Show success dialog
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const CustomPopUp(
                                  success: true,
                                );
                              },
                            );
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                    ),
                    child: Text(
                      'Pay Now ${widget.bookingInfo.totalPrice} €',
                      style: const TextStyle(
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
      ),
    );
  }
}
