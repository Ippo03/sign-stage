import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sign_stage/models/main/ticket.dart';
import 'package:sign_stage/models/main/user.dart';
import 'package:sign_stage/screens/main/home_screen.dart';
import 'package:sign_stage/widgets/custom/custom_info_field.dart';
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
  void initState() {
    super.initState();
    _checkPermission();
  }

  Future<void> _checkPermission() async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      print('Permission granted');
    } else {
      print('Permission denied');
    }
  }

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomInfoField(
                infoText:
                    'Come to the theater, show your e-Ticket to the front entrance and let the staff scan the barcode.',
              ),
              const SizedBox(height: 20),
              if (user!.tickets.length > 1)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CarouselSlider(
                        items: user!.tickets.map((ticket) {
                          return ETicketItem(
                            key: ValueKey(ticket.id),
                            ticket: ticket,
                          );
                        }).toList(),
                        carouselController: _carouselController,
                        options: CarouselOptions(
                          height: 475,
                          enlargeCenterPage: true,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                )
              else if (user!.tickets.length == 1)
                ETicketItem(
                  key: ValueKey(user!.tickets[0].id),
                  ticket: user!.tickets[0],
                )
              else
                const Center(
                  child: Text(
                    'No tickets available',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              const SizedBox(height: 10),
              Center(
                child: user!.tickets.isNotEmpty
                    ? ElevatedButton(
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

                                      // remove the ticket from the play's available dates
                                      Ticket ticket = user!.tickets[_currentIndex];
                                      String timeOfDay = ticket.bookingInfo.selectedTime == "18:00" ? "afternoon" : "night";
                                      ticket.play.availableDates[ticket.bookingInfo.selectedDate]![
                                          timeOfDay]!
                                          .remove(ticket);

                                      // remove the ticket from the user's tickets      
                                      user!.tickets.removeAt(_currentIndex);

                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return const CustomPopUp(
                                              success: false);
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                        ),
                        child: const Text(
                          'Cancel E-Ticket',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
