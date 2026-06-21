import 'package:flutter/material.dart';
import '../../../chatbot/presentation/pages/pharmacy_chatbot_page.dart';
import '../../../finance/presentation/pages/pharmacy_finance_page.dart';
import '../../../home/presentation/pages/pharmacy_home_page.dart';
import '../../../inventory/presentation/pages/pharmacy_inventory_page.dart';
import '../../../settings/presentation/pages/pharmacy_settings_page.dart';
import '../widgets/pharmacy_bottom_nav_bar.dart';

class PharmacyLayout extends StatefulWidget {
  const PharmacyLayout({super.key});
  @override
  State<PharmacyLayout> createState() => _PharmacyLayoutState();
}

class _PharmacyLayoutState extends State<PharmacyLayout> {
  int _selectedIndex = 0;
  final List<Widget> _pages = const [
    PharmacyHomePage(),
    PharmacyChatbotPage(),
    PharmacyFinancePage(),
    PharmacyInventoryPage(),
    PharmacySettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: PharmacyBottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
