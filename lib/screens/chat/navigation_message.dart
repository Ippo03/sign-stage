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
      borderRadius: BorderRadius.circular(24.0), // Adjust the border radius as needed
      splashColor: Colors.blue.withOpacity(0.5), // Customize the splash color
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(24.0),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Navigate to appropriate screen',
              style: TextStyle(color: Colors.white, fontSize: 13.0),
            ),
            SizedBox(width: 8.0),
            Icon(
              Icons.open_in_new,
              color: Colors.white,
              size: 15,
            ),
          ],
        ),
      ),
    );
  }
}

Widget? mapResponseCodeToWidget(String code) {
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
    default:
      return null;
  }
}
