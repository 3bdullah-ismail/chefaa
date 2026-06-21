import 'package:chefaa/core/resources/color_manager.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/resources/styles_manager.dart';

import '../../../../doctor/profile/presentation/widgets/section_title.dart';
import '../../../../patient/profile/presentation/widgets/item_container.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_tile.dart';


class PharmacyProfilePage extends StatelessWidget {
  const PharmacyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProfileHeader(),

            const SizedBox(height: 30),

            const SectionTitle(title: "Account"),
            const ProfileTile(
              icon: Icons.person_outline,
              title: "Edit Profile",
            ),
            const ProfileTile(
              icon: Icons.location_on_outlined,
              title: "Address",
            ),

            const SizedBox(height: 10),

            const SectionTitle(title: "Preferences"),
            const ProfileTile(
              icon: Icons.notifications_none,
              title: "Notifications",
            ),
            const ProfileTile(
              icon: Icons.payment_outlined,
              title: "Payment Methods",
            ),
            const ProfileTile(
              icon: Icons.lock_outline,
              title: "Privacy & Security",
            ),
            const ProfileTile(
              icon: Icons.help_outline,
              title: "Help Center",
            ),

            const SizedBox(height: 30),

          Center(
            child: ItemContainer(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/svg_images/Logout.svg",
                    colorFilter: const ColorFilter.mode(
                      ColorManager.error,
                      BlendMode.srcIn,
                    ),
                  ),
                  24.horizontalSpace,
                  Text(
                    "Logout",
                    style: getSemiBoldStyle(
                      color: ColorManager.error,
                      fontSize: 20.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}