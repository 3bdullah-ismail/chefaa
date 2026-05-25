import 'package:chefaa/core/resources/color_manager.dart';
import 'package:flutter/material.dart';

import '../../dashboard/presentation/pages/facility_dashboard_page.dart';
import '../../profile/presentation/pages/facility_profile.dart';
import '../../services/presentation/pages/services.dart';
import '../widgets/facility_bottom_nav_bar.dart';

class FacilityLayout extends StatefulWidget {
  const FacilityLayout({super.key});

  @override
  State<FacilityLayout> createState() => _FacilityLayoutState();
}

class _FacilityLayoutState extends State<FacilityLayout> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    FacilityDashboardPage(),
    ServicesPage(),
    FacilityProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.lightGray,
      body: _pages[_currentIndex],
      bottomNavigationBar: FacilityBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
