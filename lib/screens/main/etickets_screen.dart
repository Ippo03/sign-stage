import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sign_stage/models/main/user.dart';
import 'package:sign_stage/screens/main/home_screen.dart';
import 'package:sign_stage/widgets/custom/custom_pop_up.dart';
import 'package:sign_stage/widgets/entities/eticket_item.dart';

class ETicketsScreen extends StatefulWidget {
  const ETicketsScreen({super.key});

  @override
  _ETicketsScreenState createState() => _ETicketsScreenState();
}

class _ETicketsScreenState extends State<ETicketsScreen> {
  final user = User.instance;
  final CarouselController _carouselController = CarouselController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    print(' Tickets len ${user!.tickets.length}');

    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
            (route) => false,
          ),
        ),
        title: const Text(
          'My E-Tickets',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Instruction',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Come to the theater, show your e-Ticket to the front entrance and let the staff scan the barcode.',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            if (user!.tickets.length > 1)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => _carouselController.previousPage(),
                  ),
                  Expanded(
                    child: CarouselSlider(
                      items: user!.tickets
                          .map((ticket) => ETicketItem(ticket: user!.tickets[_currentIndex]))
                          .toList(),
                      carouselController: _carouselController,
                      options: CarouselOptions(
                        height: 400,
                        enlargeCenterPage: true,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward, color: Colors.white),
                    onPressed: () => _carouselController.nextPage(),
                  ),
                ],
              )
            else if (user!.tickets.length == 1)
              ETicketItem(ticket: user!.tickets[0])
            else
              const Center(
                child: Text(
                  'No tickets available',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            const SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: const Text(
                  'Download E-Ticket',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Cancel E-Ticket'),
                        content: const Text(
                          'Are you sure you want to cancel this E-Ticket?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('No'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();

                              user!.tickets.removeAt(_currentIndex);
                              
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return const CustomPopUp(success: false);
                                },
                              );
                            },
                            child: const Text('Yes'),
                          ),
                        ],
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: const Text(
                  'Cancel E-Ticket',
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
