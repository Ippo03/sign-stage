import 'package:flutter/material.dart';
import 'package:sign_stage/models/user.dart';
import 'package:sign_stage/screens/main/etickets_screen.dart';
import 'package:sign_stage/screens/main/login_screen.dart';
import 'package:sign_stage/screens/secondary/contact_details_screen.dart';
import 'package:sign_stage/screens/secondary/make_compalints_screen.dart';
import 'package:sign_stage/widgets/entities/setting_list_item.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  final User user = User.instance!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: const Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/profile_picture.jpg'),
            ),
            accountName: Text(
              'John Doe',
              style: TextStyle(color: Colors.white),
            ),
            accountEmail: Text(
              'Film Hunter, Movie Lover',
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: 16.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Account',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
          ),
          SettingsListItem(
            icon: Icons.person,
            iconColor: Colors.blue,
            title: 'Personal Data',
            navigateTo: LoginScreen(),
            textColor: Colors.white,
          ),
          SettingsListItem(
            icon: Icons.credit_card,
            iconColor: Colors.teal,
            title: 'Payment',
            navigateTo: LoginScreen(),
            textColor: Colors.white,
          ),
          SettingsListItem(
            icon: Icons.delete,
            iconColor: Colors.red,
            title: 'Deactivate Account',
            navigateTo: LoginScreen(),
            textColor: Colors.white,
          ),
          SizedBox(height: 16.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Privacy & Policy',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
          ),
          SettingsListItem(
            icon: Icons.contact_phone,
            iconColor: Colors.blue,
            title: 'Contact Details',
            navigateTo: ContactDetailsScreen(),
            textColor: Colors.white,
          ),
          SettingsListItem(
            icon: Icons.confirmation_number,
            iconColor: Colors.teal,
            title: 'Your E-Tickets',
            navigateTo: ETicketsScreen(),
            textColor: Colors.white,
          ),
          SettingsListItem(
            icon: Icons.report,
            iconColor: Colors.blueGrey,
            title: 'Make Complaints',
            navigateTo: MakeComplaintsScreen(),
            textColor: Colors.white,
          ),
          SettingsListItem(
            icon: Icons.logout,
            iconColor: Colors.red,
            title: 'Logout',
            navigateTo: LoginScreen(), // Replace with your logout logic
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
