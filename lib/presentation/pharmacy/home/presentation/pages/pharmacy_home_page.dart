import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/widget/inside_app_bar.dart';
import 'package:flutter/material.dart';

import 'brief_page.dart';
import 'delivery_page.dart';

class PharmacyHomePage extends StatelessWidget {
  const PharmacyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: ColorManager.lightGray.withValues(alpha: 0.3),
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: InsideAppBar(
            title: "Elmokhtabar Pharmacy",
            isLayout: true,
            subtitle: "opened 5 mins ago",
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: ColorManager.white,
              child: const TabBar(
                indicatorColor: ColorManager.primary,
                labelColor: ColorManager.primary,
                unselectedLabelColor: ColorManager.darkGray,
                indicatorWeight: 3,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: [
                  Tab(icon: Icon(Icons.dashboard_outlined), text: "Brief"),
                  Tab(
                    icon: Icon(Icons.local_shipping_outlined),
                    text: "Delivery",
                  ),
                ],
              ),
            ),

            const Expanded(
              child: TabBarView(
                children: [
                  BriefTab(
                    totalCompleted: 1200,
                    netEarnings: 1188,
                    staffAvailable: 3,
                    staffBusy: 2,
                    staffTotal: 5,
                  ),

                  DeliveryTab(staffAvailable: 3, staffBusy: 2, staffTotal: 5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
