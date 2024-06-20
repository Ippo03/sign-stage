import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sign_stage/data/plays.dart';
import 'package:sign_stage/models/main/user.dart';
import 'package:sign_stage/screens/chat/base_screen.dart';
import 'package:sign_stage/screens/secondary/settings_screen.dart';
import 'package:sign_stage/widgets/entities/play_list_item.dart';
import 'package:sign_stage/widgets/progress_bar/progress_bar_state.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({
    super.key,
  });

  final User user = User.instance!;

  List<String> _calculateCurrentMonth() {
    DateTime now = DateTime.now();
    DateTime oneMonthLater = now.add(const Duration(days: 30));

    String fromDate = DateFormat.yMd().format(now); 
    String toDate = DateFormat.yMd().format(oneMonthLater); 

    return [fromDate, toDate];
  }

  List<String> _calculateNextMonth() {
    DateTime now = DateTime.now();
    DateTime oneMothLater = now.add(const Duration(days: 30));
    DateTime twoMonthsLater = now.add(const Duration(days: 61));

    String fromDate = DateFormat.yMd().format(oneMothLater); 
    String toDate = DateFormat.yMd().format(twoMonthsLater); 

    return [fromDate, toDate];
  }

  @override
  Widget build(BuildContext context) {
    ProgressBarState progressBarState = ProgressBarState();
    progressBarState.updateProgress(1);

    return BaseScreen(
      body: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0), 
          child: AppBar(
            backgroundColor: Colors.grey[800],
            automaticallyImplyLeading: false, 
          ),
        ),
        backgroundColor: Colors.grey[800],
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fitWidth, 
                  ),
                  Positioned(
                    top: 16.0,
                    left: 16.0,
                    child: IconButton(
                      icon: const Icon(Icons.settings),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SettingsScreen(),
                          ),
                        );
                      },
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Current plays',
                      style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'From ${_calculateCurrentMonth()[0]} to ${_calculateCurrentMonth()[1]}',
                      style: const TextStyle(fontSize: 16, color: Colors.white, fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
              PlayListItem(
                play: plays[0],
              ),
              PlayListItem(
                play: plays[1],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Upcoming plays',
                      style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'From ${_calculateNextMonth()[0]} to ${_calculateNextMonth()[1]}',
                      style: const TextStyle(fontSize: 16, color: Colors.white, fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
              PlayListItem(
                play: plays[2],
              ),
              PlayListItem(
                play: plays[3],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
