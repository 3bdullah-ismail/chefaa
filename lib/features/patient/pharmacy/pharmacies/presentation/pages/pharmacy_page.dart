import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';
import 'package:chefaa/core/widgets/inside_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chefaa/features/patient/pharmacy/medicines/data/models/medicine_model.dart';
import 'package:chefaa/core/config/get_config.dart';
import 'package:chefaa/features/patient/pharmacy/pharmacies/presentation/manager/pharmacy_search_cubit.dart';
import 'package:chefaa/features/patient/pharmacy/pharmacies/presentation/widgets/pharmacy_dynamic_list.dart';
import 'package:chefaa/features/patient/pharmacy/pharmacies/presentation/widgets/pharmacy_filters.dart';
import 'package:chefaa/features/patient/pharmacy/pharmacies/presentation/widgets/pharmacy_header.dart';
import 'package:chefaa/features/patient/pharmacy/pharmacies/presentation/widgets/pharmacy_search_bar.dart';

class PharmacyPage extends StatefulWidget {
  const PharmacyPage({super.key});

  @override
  State<PharmacyPage> createState() => _PharmacyPageState();
}

class _PharmacyPageState extends State<PharmacyPage> {
  int _selectedFilterIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  late final PharmacySearchCubit _searchCubit;

  final List<String> _filters = ['Pharmacies', 'Medicines', 'Nearby'];
  final List<MedicineModel> medicines = const [
    MedicineModel(
      id: "1",
      name: "Paracetamol 500mg",
      category: "Acetaminophen",
      price: 10,
      quantity: 10,
      requiresPrescription: false,
    ),
    MedicineModel(
      id: "2",
      name: "Amoxicillin 500mg",
      category: "Amoxicillin",
      price: 15,
      quantity: 10,
      requiresPrescription: false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _searchCubit = getIt<PharmacySearchCubit>()..searchPharmacies("");
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _searchCubit,
      child: Scaffold(
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
                PharmacySearchBar(
                  controller: _searchController,
                  onChanged: (value) {
                    _searchCubit.searchPharmacies(value);
                  },
                ),
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
                      pharmacyId: "",
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
    );
  }
}
