import 'package:chefaa/core/widget/inside_app_bar.dart';
import 'package:flutter/material.dart';
import '../widgets/alert_new_order.dart';
import '../widgets/order_tabs.dart';
import '../widgets/order_list.dart';

class PharmacyOrderPage extends StatefulWidget {
  const PharmacyOrderPage({super.key});

  @override
  State<PharmacyOrderPage> createState() => _PharmacyOrderPageState();
}

class _PharmacyOrderPageState extends State<PharmacyOrderPage> {
  int selectedIndex = 0;

  final List<String> tabs = ["All", "New", "Complete"];

  final List<Map<String, String>> orders = [
    {
      "id": "1001",
      "name": "Ahmed Ali",
      "status": "New",
      "date": "Today",
      "price": "120 EGP",
      "items": "3 items",
    },
    {
      "id": "1002",
      "name": "Sara Mohamed",
      "status": "Complete",
      "date": "Yesterday",
      "price": "80 EGP",
      "items": "2 items",
    },
    {
      "id": "1003",
      "name": "Omar Khaled",
      "status": "New",
      "date": "Today",
      "price": "200 EGP",
      "items": "5 items",
    },
  ];

  List<Map<String, String>> get filteredOrders {
    if (selectedIndex == 0) return orders;
    if (selectedIndex == 1) {
      return orders.where((e) => e["status"] == "New").toList();
    }
    return orders.where((e) => e["status"] == "Complete").toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),

      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: InsideAppBar(
          title: "Orders",
          isLayout: true,
          subtitle: "Manage all incoming and completed orders",
        ),
      ),

      body: Column(
        children: [
         const  NewOrderAlertCard(count: 2,),
          OrderTabs(
            tabs: tabs,
            selectedIndex: selectedIndex,
            onTabSelected: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),

          Expanded(
            child: OrderList(orders: filteredOrders),
          ),
        ],
      ),
    );
  }
}