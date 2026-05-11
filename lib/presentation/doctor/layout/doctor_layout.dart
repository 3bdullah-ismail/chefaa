import 'package:chefaa/presentation/doctor/layout/home/presentation/pages/doctor_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/resources/assets_manager.dart';
import '../../../core/resources/color_manager.dart';
import '../../../core/resources/styles_manager.dart';

class DoctorLayout extends StatefulWidget {
  const DoctorLayout({super.key});

  @override
  State<DoctorLayout> createState() => _DoctorLayoutState();
}

class _DoctorLayoutState extends State<DoctorLayout> {
  int _selectedIndex = 0;
  List<Widget> tabs = [
    const DoctorHome(),
    const Center(child: Text("Patient")),
    const Center(child: Text("Profile")),
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
            icon: SvgPicture.asset(
              SvgAssets.patient,
              width: 32.w,
              height: 32.h,
            ),
            label: 'Patients',
            activeIcon: SvgPicture.asset(
              SvgAssets.patientActive,
              width: 32.w,
              height: 32.h,
            ),
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
