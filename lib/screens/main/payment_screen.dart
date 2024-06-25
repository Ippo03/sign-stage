import 'dart:collection';

import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';
import 'package:sign_stage/data/plays.dart';
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
  int _currentCardIndex = 0;
  final PageController _pageController = PageController();

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
    _pageController.dispose();
    super.dispose();
  }

  void _onCardSelected(CreditCard card) {
    setState(() {
      emailController.text = user!.email;
      cardholderNameController.text = card.cardHolderName;
      cardNumberController.text = card.cardNumber;
      expirationDateController.text = card.expiryDate;
      cvvController.text = card.cvvCode;
    });
  }

  bool _validateFields() {
    return emailController.text.isNotEmpty &&
        cardholderNameController.text.isNotEmpty &&
        cardNumberController.text.isNotEmpty &&
        expirationDateController.text.isNotEmpty &&
        cvvController.text.isNotEmpty;
  }

  Future<void> _showConfirmationDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Payment'),
          content: Text(
              'Are you sure you want to proceed with the payment of ${widget.bookingInfo.totalPrice}€?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Proceed'),
              onPressed: () {
                Navigator.of(context).pop();
                _processPayment();
              },
            ),
          ],
        );
      },
    );
  }

  void _processPayment() {
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

    // Update plays tickets
    final playIndex = plays.indexWhere(
      (play) => play.title == widget.play.title,
    );

    final String timeOfDay =
        widget.play.afternoon == widget.bookingInfo.selectedTime
            ? 'afternoon'
            : 'night';

    DateTime selectedDate = widget.bookingInfo.selectedDate;

    if (plays[playIndex].availableDates.containsKey(selectedDate)) {
      // Date already exists, check if timeOfDay exists
      if (plays[playIndex]
          .availableDates[selectedDate]!
          .containsKey(timeOfDay)) {
        // Add the ticket to the existing list for the specified timeOfDay
        plays[playIndex].availableDates[selectedDate]![timeOfDay]!.add(ticket);
      } else {
        // Create a new list for the specified timeOfDay and add the ticket
        plays[playIndex].availableDates[selectedDate]![timeOfDay] = [ticket];
      }
    } else {
      // Date does not exist, create new entry for selectedDate and add the ticket
      plays[playIndex].availableDates[selectedDate] = HashMap.from({
        timeOfDay: [ticket]
      });
    }

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

  void _onPageChanged(int index) {
    setState(() {
      _currentCardIndex = index;
    });
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
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: Text(
                  'Payment Method',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Hold a card for 2 seconds to auto-fill the payment details.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                height: 260,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  itemCount: user!.creditCards.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: CustomCreditCard(
                        index: index,
                        onCardSelected: _onCardSelected,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  user!.creditCards.length,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    width: 8.0,
                    height: 8.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentCardIndex == index
                          ? Colors.blue
                          : Colors.grey,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Payment Details',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CustomTextField(
                  label: 'Your Email',
                  controller: emailController,
                  hintText: 'johnDoe@example.com',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CustomTextField(
                  label: 'Cardholder Name',
                  controller: cardholderNameController,
                  hintText: 'John Doe',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CustomTextField(
                  label: 'Card Number',
                  controller: cardNumberController,
                  hintText: '**** **** **** 51446',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
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
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _validateFields()
                      ? () {
                          _showConfirmationDialog();
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
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
