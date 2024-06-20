import 'dart:collection';
import 'dart:convert';

import 'package:sign_stage/models/main/play.dart';
import 'package:sign_stage/models/main/ticket.dart';
import 'package:sign_stage/models/util/booking_info.dart';
import 'package:sign_stage/models/util/ticket_type.dart';

// Parser function that takes a JSON string as input
List<Play> parsePlaysFromJson(String jsonString) {
  final List<dynamic> jsonData = json.decode(jsonString);

  return jsonData
      .map<Play>((json) => Play(
            title: json['title'],
            headline: json['headline'],
            description: json['description'],
            author: json['author'],
            cast: List<String>.from(json['cast']),
            genre: json['genre'],
            runtime: json['runtime'],
            afternoon: json['afternoon'],
            night: json['night'],
            availableDates: parseAvailableDates(json['availableDates']),
            regularTickets: TicketType(
              name: json['regularTickets']['name'],
              price: json['regularTickets']['price'],
              availableTickets: json['regularTickets']['availableTickets'],
              soldTickets: json['regularTickets']['soldTickets'],
            ),
            specialNeedsTickets: TicketType(
              name: json['specialNeedsTickets']['name'],
              price: json['specialNeedsTickets']['price'],
              availableTickets: json['specialNeedsTickets']['availableTickets'],
              soldTickets: json['specialNeedsTickets']['soldTickets'],
            ),
            hall: json['hall'],
            ageLimit: json['ageLimit'],
            additionalInfo: json['additionalInfo'],
            hearingImpaired: json['hearingImpaired'],
            imageUrl: json['imageUrl'],
          ))
      .toList();
}

HashMap<DateTime, List<Ticket?>> parseAvailableDates(
    Map<String, dynamic> json) {
  HashMap<DateTime, List<Ticket?>> availableDates =
      HashMap<DateTime, List<Ticket?>>();

  json.forEach((key, value) {
    // Convert the date string into DateTime object
    DateTime date = DateTime.parse(key);

    // Initialize an empty list for tickets
    List<Ticket?> tickets = [];

    // If the value is not null and is a list, parse each ticket
    if (value != null && value.toString() != '[]' && value is List) {
      value.forEach((ticketJson) {
        tickets.add(Ticket(
          id: ticketJson['id'] ?? '',
          play: Play.fromJson(ticketJson['play']),
          bookingInfo: BookingInfo.fromJson(ticketJson['bookingInfo']),
          status: ticketJson['status'] ?? '',
          barcode: ticketJson['barcode'] ?? '',
        ));
      });
    }

    // Add the date and corresponding list of tickets to the map
    availableDates[date] = tickets;
  });

  return availableDates;
}
