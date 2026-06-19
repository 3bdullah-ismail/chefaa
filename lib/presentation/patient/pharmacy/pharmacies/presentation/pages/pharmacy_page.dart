import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';
import 'package:chefaa/core/widget/inside_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../medicines/data/models/medicine_model.dart';
import '../widgets/pharmacy_dynamic_list.dart';
import '../widgets/pharmacy_filters.dart';
import '../widgets/pharmacy_header.dart';
import '../widgets/pharmacy_search_bar.dart';

class PharmacyPage extends StatefulWidget {
  const PharmacyPage({super.key});

  @override
  State<PharmacyPage> createState() => _PharmacyPageState();
}

class _PharmacyPageState extends State<PharmacyPage> {
  int _selectedFilterIndex = 0;

  final List<String> _filters = ['Pharmacies', 'Medicines', 'Nearby'];
  final List<MedicineModel> medicines = const [
    MedicineModel(
      name: "Paracetamol 500mg",
      activeIngredient: "Acetaminophen",
      price: "10 EGP",
    ),
    MedicineModel(
      name: "Amoxicillin 500mg",
      activeIngredient: "Amoxicillin",
      price: "15 EGP",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(120),
        child: InsideAppBar(
          title: 'Pharmacy',
          subtitle: 'Find the best pharmacies and medicines near you',
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p20,
              vertical: AppPadding.p16,
            ),
            child: Column(
              children: [
                const PharmacySearchBar(),
                15.verticalSpace,

                PharmacyFilters(
                  filters: _filters,
                  selectedIndex: _selectedFilterIndex,
                  onChanged: (index) {
                    setState(() {
                      _selectedFilterIndex = index;
                    });
                  },
                ),
              ],
            ),
          ),

          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorManager.lightGray,
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(AppPadding.p20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PharmacyHeader(title: _filters[_selectedFilterIndex]),

                    20.verticalSpace,

                    PharmacyDynamicList(
                      selectedIndex: _selectedFilterIndex,
                      medicines: medicines,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
