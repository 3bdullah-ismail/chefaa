import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/presentation/patient/profiile/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/resources/assets_manager.dart';

class PatientLayout extends StatefulWidget {
  const PatientLayout({super.key});

  @override
  State<PatientLayout> createState() => _PatientLayoutState();
}

class _PatientLayoutState extends State<PatientLayout> {
  int _selectedIndex = 0;
  List<Widget> tabs = [
    const Center(child: Text("Home")),
    const Center(child: Text("Booking")),
    const Center(child: Text("AiLab")),
    const Center(child: Text("Chat")),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: getSemiBoldStyle(color: ColorManager.darkGray),
        unselectedLabelStyle: getSemiBoldStyle(color: ColorManager.darkGray),
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(SvgAssets.home, width: 20, height: 20),
            label: 'Home',
            activeIcon: SvgPicture.asset(
              SvgAssets.homeActive,
              width: 20,
              height: 20,
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(SvgAssets.booking),
            label: 'Booking',
            activeIcon: SvgPicture.asset(SvgAssets.bookingActive),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(SvgAssets.aiLab, width: 25, height: 25),
            label: 'AILab',
            activeIcon: SvgPicture.asset(
              SvgAssets.aiLabActive,
              width: 25,
              height: 25,
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(SvgAssets.chat),
            label: 'Chat',
            activeIcon: SvgPicture.asset(SvgAssets.chatActive),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(SvgAssets.profile),
            label: 'Me',
            activeIcon: SvgPicture.asset(SvgAssets.profileActive),
          ),
        ],
        backgroundColor: ColorManager.white,
        selectedItemColor: ColorManager.primary,
        unselectedItemColor: ColorManager.gray,
        showUnselectedLabels: true,
        currentIndex: _selectedIndex,
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
      ),
    );
  }
}
