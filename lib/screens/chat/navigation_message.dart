import 'package:flutter/material.dart';
import 'package:sign_stage/data/plays.dart';
import 'package:sign_stage/models/main/play.dart';
import 'package:sign_stage/screens/main/booking_screen.dart';
import 'package:sign_stage/screens/main/etickets_screen.dart';
import 'package:sign_stage/screens/main/play_details_screen.dart';
import 'package:sign_stage/screens/secondary/make_compalints_screen.dart';
import 'package:sign_stage/screens/secondary/theater_info_screen.dart';

class NavigationMessage extends StatelessWidget {
  final String responseCode;
  final String responseText;
  final String? responsePlayTitle;

  const NavigationMessage({
    Key? key,
    required this.responseCode,
    required this.responseText,
    this.responsePlayTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.7,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 4.0),
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            responseText,
            style: const TextStyle(color: Colors.black, fontSize: 14.0),
          ),
          const SizedBox(height: 10.0),
          InkWell(
            onTap: () {
              print('Navigating to the appropriate screen...');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      mapResponseCodeToWidget(responseCode, responsePlayTitle)!,
                ),
              );
            },
            borderRadius: BorderRadius.circular(24.0),
            splashColor: Colors.blue.withOpacity(0.5),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(24.0),
              ),
              child: const Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Go to screen',
                      style: TextStyle(color: Colors.white, fontSize: 13.0),
                    ),
                    SizedBox(width: 8.0),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 15,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget? mapResponseCodeToWidget(String code, String? responseText) {
  print('Response text before mapping: $responseText');
  responseText ??= '';
  print('Response text after mapping: $responseText');
  print('Plays inside map code {plays}');
  
  Play? responsePlay = findPlayByTitle(plays, responseText);
  print('Play inside map code {responsePlay}');

  switch (code) {
    case 'USER_WANTS_TO_GET_THEATER_INFO':
    case 'USER_WANTS_TO_GET_DIRECTIONS':
    case 'USER_WANTS_TO_CONTACT_A_HUMAN':
      return const TheaterInfoScreen();
    case 'USER_WANTS_TO_SUBMIT_A_COMPLAINT':
      return const MakeComplaintsScreen();
    case 'USER_CANCELS_TICKET':
    case 'USER_SEES_PURCHASED_TICKETS':
      return const ETicketsScreen();
    case 'USER_CHOSE_THE_PLAY':
      return BookingScreen(play: responsePlay!);
    case 'USER_WANTS_TO_GET_PLAY_INFO':
      print('Play inside get info code {responsePlay}');
      return PlayDetailsScreen(play: responsePlay!);
    default:
      return null;
  }
}
