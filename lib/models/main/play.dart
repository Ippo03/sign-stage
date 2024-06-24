import 'dart:collection';

import 'package:sign_stage/models/main/ticket.dart';
import 'package:sign_stage/models/util/ticket_type.dart';
import 'package:sign_stage/parser/json_parser.dart';

class Play {
  Play({
    required this.title,
    required this.headline,
    required this.description,
    required this.author,
    required this.cast,
    required this.genre,
    required this.runtime,
    required this.availableDates,
    required this.afternoon,
    required this.night,
    required this.regularTickets,
    required this.specialNeedsTickets,
    required this.hall,
    required this.ageLimit,
    required this.additionalInfo,
    required this.hearingImpaired,
    required this.imageUrl,
  });

  String title;
  String headline;
  String description;
  String author;
  List<String> cast;
  String genre;
  String runtime;
  HashMap<DateTime, HashMap<String, List<Ticket?>>> availableDates =
      HashMap<DateTime, HashMap<String, List<Ticket?>>>();
  String afternoon;
  String night;
  TicketType regularTickets;
  TicketType specialNeedsTickets;
  String hall;
  String ageLimit;
  String additionalInfo;
  bool hearingImpaired = false;
  String imageUrl;

  factory Play.fromJson(Map<String, dynamic> json) {
    return Play(
      title: json['title'],
      headline: json['headline'],
      description: json['description'],
      author: json['author'],
      cast: List<String>.from(json['cast']),
      genre: json['genre'],
      runtime: json['runtime'],
      availableDates: parseAvailableDates(json['availableDates']),
      afternoon: json['afternoon'],
      night: json['night'],
      regularTickets: TicketType.fromJson(json['regularTickets']),
      specialNeedsTickets: TicketType.fromJson(json['specialNeedsTickets']),
      hall: json['hall'],
      ageLimit: json['ageLimit'],
      additionalInfo: json['additionalInfo'],
      hearingImpaired: json['hearingImpaired'],
      imageUrl: json['imageUrl'],
    );
  }

  // getters
  // Day of week, day of month month and year
  String get fullDateTime =>
      '${availableDates.keys.first.weekday}, ${availableDates.keys.first.day} ${availableDates.keys.first.month} ${availableDates.keys.first.year}';
  int get totalAvailableTickets =>
      regularTickets.availableTickets + specialNeedsTickets.availableTickets;
  int get totalSoldTickets =>
      regularTickets.soldTickets + specialNeedsTickets.soldTickets;

  // methods
  // function that check if a specific date is sold out
  bool isSoldOutForDateAndTime(DateTime date, String playType) {
    if (availableDates.containsKey(date) &&
        availableDates[date]!.containsKey(playType)) {
         int ticketsSold = 0;
          for (var ticket in availableDates[date]![playType]!) {
            ticketsSold += ticket!.bookingInfo.selectedSeats.length;
          }
      return ticketsSold >= totalAvailableTickets;
    }
    return false;
  }

// Function that returns the number of available tickets for a specific date and play type
  int availableTicketsForDateAndTime(DateTime date, String playType) {
    if (availableDates.containsKey(date) &&
        availableDates[date]!.containsKey(playType)) {
          int ticketsSold = 0;
          for (var ticket in availableDates[date]![playType]!) {
            ticketsSold += ticket!.bookingInfo.selectedSeats.length;
          }
      return totalAvailableTickets - ticketsSold;
    }
    return totalAvailableTickets;
  }

// Function that finds the status of the tickets for a specific date and play type (sold out, few available, available)
  String ticketStatusForDateAndTime(DateTime date, String playType) {
    print("im here");
    if (isSoldOutForDateAndTime(date, playType)) {
      return 'Sold Out';
    } else if (availableTicketsForDateAndTime(date, playType) <=
        totalAvailableTickets / 5) {
      return 'Few Available';
    } else {
      return 'Available';
    }
  }

  bool hearingImpairedStatusForDateAndTime(DateTime date, String playType) {
    if (isSoldOutForDateAndTime(date, playType)) return false;

    const hallAHearingImpairedSeats = ['A1', 'B1', 'A7', 'B7'];
    const hallBHearingImpairedSeats = ['A1', 'B1', 'C1', 'A8', 'B8', 'C8'];

    List<String> reservedSeats = getReservedSeatsForDateAndTime(date, playType);
    
    if (hall == 'Hall A') {
      return hallAHearingImpairedSeats.every((seat) => reservedSeats.contains(seat));
    } else {
      return hallBHearingImpairedSeats.every((seat) => reservedSeats.contains(seat));
    }
  }

// Function to get the reserved seats for a specific date and play type
  List<String> getReservedSeatsForDateAndTime(DateTime date, String playType) {
    List<String> reservedSeats = [];
    if (availableDates.containsKey(date) &&
        availableDates[date]!.containsKey(playType)) {
      availableDates[date]![playType]!.forEach((ticket) {
        if (ticket != null) {
          reservedSeats.addAll(ticket.bookingInfo.selectedSeats);
        }
      });
    }
    return reservedSeats;
  }
}
