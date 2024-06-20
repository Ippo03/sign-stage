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
  HashMap<DateTime, List<Ticket?>> availableDates = HashMap<DateTime, List<Ticket>>();
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
  String get fullDateTime => '${availableDates.keys.first.weekday}, ${availableDates.keys.first.day} ${availableDates.keys.first.month} ${availableDates.keys.first.year}';
  int get totalAvailableTickets => regularTickets.availableTickets + specialNeedsTickets.availableTickets;
  int get totalSoldTickets => regularTickets.soldTickets + specialNeedsTickets.soldTickets;

  // methods
  // function that check if a specific date is sold out
  bool isSoldOutForDate(DateTime date) {
    if (availableDates.containsKey(date)) {
      return availableDates[date]!.length >= totalAvailableTickets;
    }
    return false;
  }

  // function that returns the number of available tickets for a specific date
  int availableTicketsForDate(DateTime date) {
    if (availableDates.containsKey(date)) {
      return totalAvailableTickets - availableDates[date]!.length;
    }
    return totalAvailableTickets;
  }

  // function that finds the status of the tickets for a specific date (sold out, few available == less that 1/5, available)
  String ticketStatusForDate(DateTime date) {
    if (isSoldOutForDate(date)) {
      return 'sold out';
    } else if (availableTicketsForDate(date) <= totalAvailableTickets / 5) {
      return 'few available';
    } else {
      return 'available';
    }
  }
}