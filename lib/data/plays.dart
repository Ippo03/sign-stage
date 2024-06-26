import 'package:sign_stage/models/main/play.dart';
import 'package:sign_stage/parser/json_parser.dart';

// JSON data
const jsonString = '''
[
  {
    "title": "Hamlet",
    "headline": "A Tragic Masterpiece of Shakespearean Proportions",
    "description": "A tragedy by William Shakespeare that delves into the themes of treachery, revenge, and moral corruption.",
    "playwriter": "William Shakespeare",
    "cast": ["Benedict Cumberbatch", "David Tennant", "Ian McKellen"],
    "genre": "Tragedy",
    "runtime": "2h 30min",
    "availableDates": {
      "2024-06-26T00:00:00": {"afternoon": [], "night": []},
      "2024-06-27T00:00:00": {"afternoon": [], "night": []},
      "2024-06-28T00:00:00": {"afternoon": [], "night": []},
      "2024-06-29T00:00:00": {"afternoon": [], "night": []},
      "2024-06-30T00:00:00": {"afternoon": [], "night": []},
      "2024-07-01T00:00:00": {"afternoon": [], "night": []},
      "2024-07-02T00:00:00": {"afternoon": [], "night": []},
      "2024-07-03T00:00:00": {"afternoon": [], "night": []},
      "2024-07-04T00:00:00": {"afternoon": [], "night": []},
      "2024-07-05T00:00:00": {"afternoon": [], "night": []},
      "2024-07-06T00:00:00": {"afternoon": [], "night": []}
    },
    "afternoon": "18:00",
    "night": "22:00",
    "regularTickets": {
      "name": "regular",
      "price": 25,
      "availableTickets": 31,
      "soldTickets": 0
    },
    "specialNeedsTickets": {
      "name": "special needs",
      "price": 18,
      "availableTickets": 4,
      "soldTickets": 0
    },
    "hall": "Hall A",
    "ageLimit": "12+",
    "additionalInfo": "Includes surtitles and sign language interpreter.",
    "hearingImpaired": true,
    "imageUrl": "assets/images/hamlet.jpg"
  },
  {
    "title": "Odyssey",
    "headline": "An Epic Journey through Greek Mythology",
    "description": "An epic Greek poem attributed to Homer that tells the story of Odysseus' journey home after the Trojan War.",
    "playwriter": "Homer",
    "cast": ["Brad Pitt", "Orlando Bloom", "Diane Kruger"],
    "genre": "Epic",
    "runtime": "1h 30min",
    "availableDates": {
      "2024-06-26T00:00:00": {"afternoon": [], "night": []},
      "2024-06-27T00:00:00": {"afternoon": [], "night": []},
      "2024-06-28T00:00:00": {"afternoon": [], "night": []},
      "2024-06-29T00:00:00": {"afternoon": [], "night": []},
      "2024-06-30T00:00:00": {"afternoon": [], "night": []},
      "2024-07-01T00:00:00": {"afternoon": [], "night": []},
      "2024-07-02T00:00:00": {"afternoon": [], "night": []},
      "2024-07-03T00:00:00": {"afternoon": [], "night": []},
      "2024-07-04T00:00:00": {"afternoon": [], "night": []},
      "2024-07-05T00:00:00": {"afternoon": [], "night": []},
      "2024-07-06T00:00:00": {"afternoon": [], "night": []}
    },
    "afternoon": "18:00",
    "night": "22:00",
    "regularTickets": {
      "name": "regular",
      "price": 20,
      "availableTickets": 40,
      "soldTickets": 0
    },
    "specialNeedsTickets": {
      "name": "special needs",
      "price": 15,
      "availableTickets": 6,
      "soldTickets": 0
    },
    "hall": "Hall B",
    "ageLimit": "14+",
    "additionalInfo": "Does not include surtitles or sign language interpreter.",
    "hearingImpaired": false,
    "imageUrl": "assets/images/odyssey.jpg"
  },
  {
    "title": "The 39 Steps",
    "headline": "A Thrilling Adventure Filled with Suspense",
    "description": "A play adapted from John Buchan's novel, combining thrilling action and comedy.",
    "playwriter": "John Buchan",
    "cast": ["Daniel Craig", "Rachel Weisz", "Ralph Fiennes"],
    "genre": "Thriller",
    "runtime": "1h 20min",
    "availableDates": {
      "2024-07-06T00:00:00": {"afternoon": [], "night": []},
      "2024-07-07T00:00:00": {"afternoon": [], "night": []},
      "2024-07-08T00:00:00": {"afternoon": [], "night": []},
      "2024-07-09T00:00:00": {"afternoon": [], "night": []},
      "2024-07-10T00:00:00": {"afternoon": [], "night": []},
      "2024-07-11T00:00:00": {"afternoon": [], "night": []},
      "2024-07-12T00:00:00": {"afternoon": [], "night": []},
      "2024-07-13T00:00:00": {"afternoon": [], "night": []},
      "2024-07-14T00:00:00": {"afternoon": [], "night": []},
      "2024-07-15T00:00:00": {"afternoon": [], "night": []},
      "2024-07-16T00:00:00": {"afternoon": [], "night": []}
    },
    "afternoon": "18:00",
    "night": "22:00",
    "regularTickets": {
      "name": "regular",
      "price": 18,
      "availableTickets": 31,
      "soldTickets": 0
    },
    "specialNeedsTickets": {
      "name": "special needs",
      "price": 13,
      "availableTickets": 4,
      "soldTickets": 0
    },
    "hall": "Hall A",
    "ageLimit": "10+",
    "additionalInfo": "Includes surtitles and sign language interpreter.",
    "hearingImpaired": false,
    "imageUrl": "assets/images/39_steps.jpeg"
  },
  {
    "title": "The Seagull",
    "headline": "A Chekhovian Masterpiece of Love and Art",
    "description": "A play by Anton Chekhov that explores the complexity of human emotions and relationships.",
    "playwriter": "Anton Chekhov",
    "cast": ["Annette Bening", "Corey Stoll", "Elisabeth Moss"],
    "genre": "Drama",
    "runtime": "2h 15min",
    "availableDates": {
      "2024-07-06T00:00:00": {"afternoon": [], "night": []},
      "2024-07-07T00:00:00": {"afternoon": [], "night": []},
      "2024-07-08T00:00:00": {"afternoon": [], "night": []},
      "2024-07-09T00:00:00": {"afternoon": [], "night": []},
      "2024-07-10T00:00:00": {"afternoon": [], "night": []},
      "2024-07-11T00:00:00": {"afternoon": [], "night": []},
      "2024-07-12T00:00:00": {"afternoon": [], "night": []},
      "2024-07-13T00:00:00": {"afternoon": [], "night": []},
      "2024-07-14T00:00:00": {"afternoon": [], "night": []},
      "2024-07-15T00:00:00": {"afternoon": [], "night": []},
      "2024-07-16T00:00:00": {"afternoon": [], "night": []}
    },
    "afternoon": "18:00",
    "night": "22:00",
    "regularTickets": {
      "name": "regular",
      "price": 24,
      "availableTickets": 40,
      "soldTickets": 0
    },
    "specialNeedsTickets": {
      "name": "special needs",
      "price": 18,
      "availableTickets": 6,
      "soldTickets": 0
    },
    "hall": "Hall B",
    "ageLimit": "15+",
    "additionalInfo": "Does not include surtitles or sign language interpreter.",
    "hearingImpaired": false,
    "imageUrl": "assets/images/seagull.jpg"
  }
]
''';

List<Play> plays = parsePlaysFromJson(jsonString);

Play? findPlayByTitle(List<Play> plays, String title) {
  for (Play play in plays) {
    if (play.title.toLowerCase() == title.toLowerCase()) {
      print('Found play with title: ${play.title}');
      return play;
    }
  }
  return null;
}
