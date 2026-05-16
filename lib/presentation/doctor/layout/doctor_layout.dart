import 'package:chefaa/presentation/doctor/layout/home/presentation/manager/clinic_cubit.dart';
import 'package:chefaa/presentation/doctor/layout/home/presentation/pages/doctor_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/config/get_config.dart';
import '../../../core/resources/assets_manager.dart';
import '../../../core/resources/color_manager.dart';
import '../../../core/resources/styles_manager.dart';
import '../profile/presentation/pages/profile_page.dart';

class DoctorLayout extends StatefulWidget {
  const DoctorLayout({super.key});

  @override
  State<DoctorLayout> createState() => _DoctorLayoutState();
}

class _DoctorLayoutState extends State<DoctorLayout> {
  int _selectedIndex = 0;

  final List<Widget> _tabs = const [
    DoctorHome(),
    Center(child: Text("Patient")),
    DoctorProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ClinicCubit>(),
      child: Scaffold(
        body: _tabs[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: getSemiBoldStyle(color: ColorManager.darkGray),
          unselectedLabelStyle: getSemiBoldStyle(color: ColorManager.darkGray),
          backgroundColor: ColorManager.white,
          selectedItemColor: ColorManager.primary,
          unselectedItemColor: ColorManager.gray,
          showUnselectedLabels: true,
          currentIndex: _selectedIndex,
          onTap: (index) => setState(() => _selectedIndex = index),
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(SvgAssets.home, width: 20, height: 20),
              activeIcon: SvgPicture.asset(
                SvgAssets.homeActive,
                width: 20,
                height: 20,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                SvgAssets.patient,
                width: 32.w,
                height: 32.h,
              ),
              activeIcon: SvgPicture.asset(
                SvgAssets.patientActive,
                width: 32.w,
                height: 32.h,
              ),
              label: 'Patients',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(SvgAssets.profile),
              activeIcon: SvgPicture.asset(SvgAssets.profileActive),
              label: 'Me',
            ),
          ],
        ),
      ),
    );
  }
}
