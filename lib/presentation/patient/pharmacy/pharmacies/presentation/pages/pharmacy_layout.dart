import 'package:chefaa/presentation/patient/order/presentation/pages/track_order_page.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/resources/color_manager.dart';
import '../../../../../../core/resources/styles_manager.dart';
import '../../../../cart/presentation/pages/cart_page.dart';
import 'pharmacy_page.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;

  final List<Widget> tabs = [
    const PharmacyPage(),
    const CartPage(),
    const TrackOrderPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,

        backgroundColor: ColorManager.white,

        currentIndex: _selectedIndex,

        selectedItemColor: ColorManager.primary,
        unselectedItemColor: ColorManager.gray,

        showUnselectedLabels: true,

        selectedLabelStyle: getSemiBoldStyle(
          color: ColorManager.primary,
          fontSize: 12,
        ),

        unselectedLabelStyle: getSemiBoldStyle(
          color: ColorManager.gray,
          fontSize: 12,
        ),

        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_rounded,
              size: 24,
            ),
            activeIcon: Icon(
              Icons.home_rounded,
              size: 26,
            ),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart_outlined,
              size: 24,
            ),
            activeIcon: Icon(
              Icons.shopping_cart_rounded,
              size: 26,
            ),
            label: 'Cart',
          ),

          BottomNavigationBarItem(
            icon: Icon(
              Icons.receipt_long_outlined,
              size: 24,
            ),
            activeIcon: Icon(
              Icons.receipt_long_rounded,
              size: 26,
            ),
            label: 'Orders',
          ),
        ],
      ),
    );
  }
}