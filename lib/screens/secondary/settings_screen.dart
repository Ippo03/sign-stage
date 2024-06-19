import 'package:flutter/material.dart';
import 'package:sign_stage/models/main/user.dart';
import 'package:sign_stage/screens/main/etickets_screen.dart';
import 'package:sign_stage/screens/main/login_screen.dart';
import 'package:sign_stage/screens/secondary/contact_details_screen.dart';
import 'package:sign_stage/screens/secondary/credit_cards_screen.dart';
import 'package:sign_stage/screens/secondary/make_compalints_screen.dart';
import 'package:sign_stage/widgets/custom/custom_drawer_header.dart';
import 'package:sign_stage/widgets/entities/setting_list_item.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  final User user = User.instance!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[800],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomDrawerHeader(
              imageUrl: user.imageUrl,
              username: user.username,
              activities: user.activities,
            ),
            const SizedBox(height: 24.0),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: const Divider(
                color: Colors.white,
                thickness: 0.5,
              ),
            ),
            const SizedBox(height: 16.0),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Account',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,
                  color: Colors.white,
                ),
              ),
            ),
            const SettingsListItem(
              icon: Icons.person,
              iconColor: Colors.blue,
              title: 'Personal Data',
              navigateTo: LoginScreen(),
              textColor: Colors.white,
            ),
            const SettingsListItem(
              icon: Icons.credit_card,
              iconColor: Colors.teal,
              title: 'My Credit Cards',
              navigateTo: CreditCardsScreen(),
              textColor: Colors.white,
            ),
            const SettingsListItem(
              icon: Icons.delete,
              iconColor: Colors.red,
              title: 'Deactivate Account',
              navigateTo: LoginScreen(),
              textColor: Colors.white,
            ),
            const SizedBox(height: 16.0),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: const Divider(
                color: Colors.white,
                thickness: 0.5,
              ),
            ),
            const SizedBox(height: 16.0),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Privacy & Policy',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,
                  color: Colors.white,
                ),
              ),
            ),
            const SettingsListItem(
              icon: Icons.contact_phone,
              iconColor: Colors.blue,
              title: 'Contact Details',
              navigateTo: ContactDetailsScreen(),
              textColor: Colors.white,
            ),
            const SettingsListItem(
              icon: Icons.confirmation_number,
              iconColor: Colors.teal,
              title: 'My E-Tickets',
              navigateTo: ETicketsScreen(),
              textColor: Colors.white,
            ),
            const SettingsListItem(
              icon: Icons.report,
              iconColor: Colors.blueGrey,
              title: 'Make Complaint',
              navigateTo: MakeComplaintsScreen(),
              textColor: Colors.white,
            ),
            const SettingsListItem(
              icon: Icons.logout,
              iconColor: Colors.red,
              title: 'Logout',
              navigateTo: LoginScreen(),
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
