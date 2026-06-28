import 'package:chefaa/core/resources/color_manager.dart';
import 'package:flutter/material.dart';

import 'package:chefaa/features/facility/dashboard/presentation/pages/facility_dashboard_page.dart';
import 'package:chefaa/features/facility/profile/presentation/pages/facility_profile_page.dart';
import 'package:chefaa/features/facility/services/presentation/pages/services_page.dart';
import 'package:chefaa/features/facility/layout/presentation/widgets/facility_bottom_nav_bar.dart';

class FacilityLayout extends StatefulWidget {
  const FacilityLayout({super.key});

  @override
  State<FacilityLayout> createState() => _FacilityLayoutState();
}

class _FacilityLayoutState extends State<FacilityLayout> {
  int _currentIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      FacilityDashboardPage(
        onNavigateToServices: () {
          setState(() {
            _currentIndex = 1;
          });
        },
      ),
      const ServicesPage(),
      const FacilityProfilePage(),
    ];
  }

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
