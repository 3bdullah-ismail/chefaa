import 'package:chefaa/core/config/get_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/resources/color_manager.dart';
import '../../../../../../core/resources/styles_manager.dart';
import '../../../../../../core/resources/values_manager.dart';
import '../../../../../../core/widget/inside_app_bar.dart';
import '../manager/pharmacy_medicines_cubit.dart';
import '../widgets/empty_medicine_state.dart';
import '../widgets/horizontal_medicine_card.dart';
import '../widgets/medicine_search_bar.dart';
import '../widgets/vertical_medicine_card.dart';

class PharmacyMedicinesPage extends StatefulWidget {
  final String pharmacyName;
  final String pharmacyId;

  const PharmacyMedicinesPage({
    super.key,
    required this.pharmacyName,
    required this.pharmacyId,
  });

  @override
  State<PharmacyMedicinesPage> createState() => _PharmacyMedicinesPageState();
}

class _PharmacyMedicinesPageState extends State<PharmacyMedicinesPage> {
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PharmacyMedicinesCubit>(
      create: (context) =>
          getIt<PharmacyMedicinesCubit>()..getPharmacyMedicines(widget.pharmacyId),
      child: Scaffold(
        backgroundColor: const Color(0xffF6F8FA),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: InsideAppBar(
            title: "${widget.pharmacyName} Meds",
            subtitle: "Fast, verified pharmaceutical delivery",
          ),
        ),
        body: BlocBuilder<PharmacyMedicinesCubit, PharmacyMedicinesState>(
          builder: (context, state) {
            if (state is PharmacyMedicinesLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: ColorManager.primary,
                ),
              );
            } else if (state is PharmacyMedicinesFailure) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline_rounded,
                        color: ColorManager.error,
                        size: 64.h,
                      ),
                      16.verticalSpace,
                      Text(
                        state.message,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ColorManager.error,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      24.verticalSpace,
                      ElevatedButton(
                        onPressed: () {
                          context
                              .read<PharmacyMedicinesCubit>()
                              .getPharmacyMedicines(widget.pharmacyId);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.primary,
                          foregroundColor: ColorManager.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text("Retry"),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is PharmacyMedicinesSuccess) {
              final medicines = state.response.medicines;
              final mostOrdered = state.response.mostOrdered;

              final filteredMedicines = medicines.where((medicine) {
                final query = searchQuery.toLowerCase();
                return medicine.name.toLowerCase().contains(query) ||
                    medicine.category.toLowerCase().contains(query);
              }).toList();

              return Column(
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
                          if (searchQuery.isEmpty && mostOrdered.isNotEmpty) ...[
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
                                    pharmacyId: widget.pharmacyId,
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
                              separatorBuilder: (_, _) =>
                                  const SizedBox(height: 12),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: filteredMedicines.length,
                              itemBuilder: (_, index) {
                                return VerticalMedicineCard(
                                  medicine: filteredMedicines[index],
                                  pharmacyId: widget.pharmacyId,
                                );
                              },
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
