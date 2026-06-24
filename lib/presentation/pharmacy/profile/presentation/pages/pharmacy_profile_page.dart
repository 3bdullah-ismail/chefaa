import 'package:flutter/material.dart';

import '../../../../doctor/profile/presentation/widgets/section_title.dart';
import 'package:chefaa/presentation/patient/profile/presentation/pages/profile_page.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_tile.dart';


class PharmacyProfilePage extends StatelessWidget {
  const PharmacyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileHeader(),

            SizedBox(height: 30),

            SectionTitle(title: "Account"),
            ProfileTile(
              icon: Icons.person_outline,
              title: "Edit Profile",
            ),
            ProfileTile(
              icon: Icons.location_on_outlined,
              title: "Address",
            ),

            SizedBox(height: 10),

            SectionTitle(title: "Preferences"),
            ProfileTile(
              icon: Icons.notifications_none,
              title: "Notifications",
            ),
            ProfileTile(
              icon: Icons.payment_outlined,
              title: "Payment Methods",
            ),
            ProfileTile(
              icon: Icons.lock_outline,
              title: "Privacy & Security",
            ),
            ProfileTile(
              icon: Icons.help_outline,
              title: "Help Center",
            ),

            SizedBox(height: 30),

            LogOutBtn(),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}