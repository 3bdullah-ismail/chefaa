import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/presentation/pharmacy/chatbot/presentation/pages/pharmacy_chatbot_page.dart';
import 'package:chefaa/presentation/pharmacy/home/presentation/pages/pharmacy_home_page.dart';
import 'package:chefaa/presentation/pharmacy/orders/presentation/pages/pharmacy_order_page.dart';
import 'package:chefaa/presentation/pharmacy/profile/presentation/pages/pharmacy_profile_page.dart';
import 'package:chefaa/presentation/pharmacy/inventory/presentation/pages/pharmacy_stock_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/resources/assets_manager.dart';

class PharmacyLayout extends StatefulWidget {
  const PharmacyLayout({super.key});

  @override
  State<PharmacyLayout> createState() => _PharmacyLayoutState();
}

class _PharmacyLayoutState extends State<PharmacyLayout> {
  int _selectedIndex = 0;
  List<Widget> tabs = [
    const PharmacyHomePage(),
    const PharmacyOrderPage(),
    const PharmacyStockPage(),
    const PharmacyChatbotPage(),
    const PharmacyProfilePage(),
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
            icon: SvgPicture.asset(SvgAssets.order, width: 25.w, height: 25.h),
            label: 'Orders',
            activeIcon: SvgPicture.asset(
              SvgAssets.orderActive,
              width: 25.w,
              height: 25.h,
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(SvgAssets.stock, width: 25.w, height: 25.h),
            label: 'Stock',
            activeIcon: SvgPicture.asset(
              SvgAssets.stockActive,
              width: 25.w,
              height: 25.h,
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(SvgAssets.chat),
            label: 'Chat',
            activeIcon: SvgPicture.asset(SvgAssets.chatActive),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(SvgAssets.profile),
            label: 'Profile',
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
