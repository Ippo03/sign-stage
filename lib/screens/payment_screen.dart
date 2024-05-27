import 'package:flutter/material.dart';
import 'package:sign_stage/widgets/custom/custom_text_field.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2D2D2D),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Checkout'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Payment Method',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.credit_card, color: Colors.red),
                      Spacer(),
                      Text(
                        '\$120,580.00',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Card Holder',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'John Doe',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '**** **** **** 51446',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
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
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                // style: ElevatedButton.styleFrom(
                //   primary: Colors.blue,
                //   padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                // ),
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
    );
  }
}
