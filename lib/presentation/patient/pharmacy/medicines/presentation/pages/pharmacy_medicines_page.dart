import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/resources/color_manager.dart';
import '../../../../../../core/resources/styles_manager.dart';
import '../../../../../../core/resources/values_manager.dart';
import '../../../../../../core/widget/inside_app_bar.dart';
import '../../data/models/medicine_model.dart';
import '../widgets/empty_medicine_state.dart';
import '../widgets/horizontal_medicine_card.dart';
import '../widgets/medicine_search_bar.dart';
import '../widgets/vertical_medicine_card.dart';

class PharmacyMedicinesPage extends StatefulWidget {
  final String pharmacyName;

  const PharmacyMedicinesPage({super.key, required this.pharmacyName});

  @override
  State<PharmacyMedicinesPage> createState() => _PharmacyMedicinesPageState();
}

class _PharmacyMedicinesPageState extends State<PharmacyMedicinesPage> {
  final TextEditingController _searchController = TextEditingController();

  String searchQuery = "";

  final List<MedicineModel> mostOrdered = const [
    MedicineModel(
      name: "Paracetamol 500mg",
      activeIngredient: "Acetaminophen",
      price: "10.00 EGP",
    ),
    MedicineModel(
      name: "Amoxicillin 500mg",
      activeIngredient: "Amoxicillin Trihydrate",
      price: "15.00 EGP",
    ),
    MedicineModel(
      name: "Panadol Extra",
      activeIngredient: "Paracetamol + Caffeine",
      price: "22.00 EGP",
    ),
  ];

  final List<MedicineModel> allMedicines = const [
    MedicineModel(
      name: "Paracetamol 500mg",
      activeIngredient: "Acetaminophen",
      price: "10.00 EGP",
    ),
    MedicineModel(
      name: "Amoxicillin 500mg",
      activeIngredient: "Amoxicillin Trihydrate",
      price: "15.00 EGP",
    ),
    MedicineModel(
      name: "Metformin 500mg",
      activeIngredient: "Metformin Hydrochloride",
      price: "12.50 EGP",
    ),
    MedicineModel(
      name: "Panadol Extra",
      activeIngredient: "Paracetamol + Caffeine",
      price: "22.00 EGP",
    ),
    MedicineModel(
      name: "Augmentin 1g",
      activeIngredient: "Amoxicillin + Clavulanic Acid",
      price: "90.00 EGP",
    ),
  ];

  List<MedicineModel> get filteredMedicines => allMedicines.where((medicine) {
    final query = searchQuery.toLowerCase();

    return medicine.name.toLowerCase().contains(query) ||
        medicine.activeIngredient.toLowerCase().contains(query);
  }).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F8FA),

      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: InsideAppBar(
          title: "${widget.pharmacyName} Meds",
          subtitle: "Fast, verified pharmaceutical delivery",
        ),
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
            child: MedicineSearchBar(
              controller: _searchController,
              query: searchQuery,
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              onClear: () {
                _searchController.clear();

                setState(() {
                  searchQuery = "";
                });
              },
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.p18,
                vertical: AppPadding.p12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (searchQuery.isEmpty) ...[
                    Text(
                      "Most Ordered",
                      style: getBoldStyle(
                        color: ColorManager.black,
                        fontSize: 16.sp,
                      ),
                    ),

                    8.verticalSpace,

                    SizedBox(
                      height: 120.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: mostOrdered.length,
                        itemBuilder: (_, index) {
                          return HorizontalMedicineCard(
                            medicine: mostOrdered[index],
                          );
                        },
                      ),
                    ),

                    20.verticalSpace,
                  ],

                  Text(
                    "All Medicines",
                    style: getBoldStyle(
                      color: ColorManager.black,
                      fontSize: 16.sp,
                    ),
                  ),

                  10.verticalSpace,

                  if (filteredMedicines.isEmpty)
                    const EmptyMedicineState()
                  else
                    ListView.separated(
                      separatorBuilder: (_, _) => const SizedBox(height: 12),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filteredMedicines.length,
                      itemBuilder: (_, index) {
                        return VerticalMedicineCard(
                          medicine: filteredMedicines[index],
                        );
                      },
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
