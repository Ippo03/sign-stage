import 'package:flutter/material.dart';
import 'package:sign_stage/screens/main/etickets_screen.dart';
import 'package:sign_stage/screens/secondary/make_compalints_screen.dart';
import 'package:sign_stage/screens/secondary/theater_info_screen.dart';

class NavigationMessage extends StatelessWidget {
  final String responseCode;

  const NavigationMessage({
    Key? key,
    required this.responseCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('Navigating to the appropriate screen...');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => mapResponseCodeToWidget(responseCode)!,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: const Text(
          'Press here to navigate to the appropriate screen.',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

Widget? mapResponseCodeToWidget(String code) {
    switch (code) {
      case 'USER_WANTS_TO_GET_THEATER_INFO':
        return const TheaterInfoScreen();
      case 'USER_WANTS_TO_GET_DIRECTIONS':
        return const TheaterInfoScreen();
      case 'USER_WANTS_TO_CONTACT_A_HUMAN':
        return const TheaterInfoScreen();
      case 'USER_WANTS_TO_SUBMIT_A_COMPLAINT':
        return const MakeComplaintsScreen();
      case 'USER_CANCELS_TICKET':
        return const ETicketsScreen();
      case 'USER_SEES_PURCHASED_TICKETS':
        return const ETicketsScreen();
      default:
        return null;
    }
  }



