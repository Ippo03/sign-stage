import 'package:flutter/material.dart';
import 'package:sign_stage/data/plays.dart';
import 'package:sign_stage/models/main/play.dart';
import 'package:sign_stage/screens/main/booking_screen.dart';
import 'package:sign_stage/screens/main/etickets_screen.dart';
import 'package:sign_stage/screens/main/play_details_screen.dart';
import 'package:sign_stage/screens/secondary/make_compalints_screen.dart';
import 'package:sign_stage/screens/secondary/theater_info_screen.dart';

String mapCodeToScreen(String code, String responsePlay) {
  switch (code) {
    case 'USER_WANTS_TO_GET_THEATER_INFO':
      return 'theater info';
    case 'USER_WANTS_TO_GET_DIRECTIONS':
      return 'theater info';
    case 'USER_WANTS_TO_CONTACT_A_HUMAN':
      return 'theater info';
    case 'USER_WANTS_TO_SUBMIT_A_COMPLAINT':
      return 'complaint form';
    case 'USER_CANCELS_TICKET':
      return 'your e-tickets';
    case 'USER_SEES_PURCHASED_TICKETS':
      return 'your e-tickets';
    case 'USER_CHOSE_THE_PLAY':
      return '"$responsePlay" booking form';
    case 'USER_WANTS_TO_GET_PLAY_INFO':
      return '"$responsePlay" info';
    default:
      return 'ChatScreen';
  }
}

bool canNavigateToScreen(String code, String? responsePlay) {
  switch (code) {
    case 'USER_WANTS_TO_GET_PLAY_INFO':
      return responsePlay!.isNotEmpty; // check again
    case 'USER_WANTS_TO_GET_THEATER_INFO':
      return true;
    case 'USER_WANTS_TO_GET_DIRECTIONS':
      return true;
    case 'USER_WANTS_TO_CONTACT_A_HUMAN':
      return true;
    case 'USER_WANTS_TO_SUBMIT_A_COMPLAINT':
      return true;
    case 'USER_CANCELS_TICKET':
      return true;
    case 'USER_SEES_PURCHASED_TICKETS':
      return true;
    case 'USER_CHOSE_THE_PLAY':
      return true;
    case 'USER_INPUT_UNRELATED_TO_THEATER':
      return false; // has extra functionality
    case 'USER_INPUT_NOT_UNDERSTANDABLE':
      return false;
    case 'USER_CHOSE_INVALID_PLAY':
      return false;
    case 'OTHER':
      return false;
    default:
      return false;
  }
}

List<String> parseCode(String responseCode) {
  List<String> results = [];
  bool isChosePlay = responseCode.startsWith('USER_CHOSE_THE_PLAY-');

  if (responseCode.startsWith('USER_CHOSE_THE_PLAY-') ||
      responseCode.startsWith('USER_WANTS_TO_GET_PLAY_INFO-')) {
    List<String> parts = responseCode.split('-');
    if (parts.length > 1) {
      String playName = parts[1];
      isChosePlay
          ? results.add('USER_CHOSE_THE_PLAY')
          : results.add('USER_WANTS_TO_GET_PLAY_INFO');
      results.add(playName);
    } else {
      results.add(responseCode);
      results.add('');
    }
  } else {
    results.add(responseCode);
    results.add('');
  }

  return results;
}

Widget? mapResponseCodeToWidget(String code, String? responseText) {
  responseText ??= '';

  Play? responsePlay = findPlayByTitle(plays, responseText);

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
    case 'USER_INPUT_NOT_UNDERSTANDABLE':
      return const TheaterInfoScreen();
    default:
      return null;
  }
}
