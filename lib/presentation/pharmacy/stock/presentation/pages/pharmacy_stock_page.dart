import 'package:chefaa/core/resources/values_manager.dart';
import 'package:chefaa/core/widget/inside_app_bar.dart';
import 'package:chefaa/presentation/patient/search/presentation/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/medicine_title.dart';
import '../widgets/section_card.dart';

class PharmacyStockPage extends StatelessWidget {
  const PharmacyStockPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F7FB),
      appBar: const PreferredSize(
        preferredSize:  Size.fromHeight(100),
        child: InsideAppBar(
          title: "Pharmacy Stock",
          isLayout: true,
          subtitle: "Track inventory, low stock alerts & medicine availability",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: Column(
          children: [
            const CustomSearchBar(text: "Search Medicines ....."),
            16.verticalSpace,

            const SectionCard(
              isAlert: true,
              title: "Low Stock Alert",
              iconColor: Colors.red,
              children: [
                MedicineTile(
                  totalStock: 80,
                  name: "Panadol",
                  category: "Painkiller",
                  stock: 3,
                  price: 25,
                  status: "Low",
                  statusColor: Colors.red,
                ),
                MedicineTile(
                  totalStock: 100,
                  name: "Amoxicillin",
                  category: "Antibiotic",
                  stock: 5,
                  price: 40,
                  status: "Low",
                  statusColor: Colors.orange,
                ),
              ],
            ),

            16.verticalSpace,
            const SectionCard(
              title: "All Medicines",
              iconColor: Colors.blue,
              children: [
                MedicineTile(
                  totalStock: 50,
                  name: "Brufen",
                  category: "Painkiller",
                  stock: 20,
                  price: 30,
                  status: "In Stock",
                  statusColor: Colors.green,
                ),
                MedicineTile(
                  totalStock: 70,
                  name: "Zinc",
                  category: "Supplement",
                  stock: 50,
                  price: 15,
                  status: "In Stock",
                  statusColor: Colors.green,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
