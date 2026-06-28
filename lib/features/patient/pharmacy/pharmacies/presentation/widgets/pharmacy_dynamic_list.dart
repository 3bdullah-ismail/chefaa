import 'package:flutter/material.dart';

import 'package:chefaa/features/patient/pharmacy/medicines/data/models/medicine_model.dart';
import 'medicine_list.dart';
import 'nearby_list.dart';
import 'pharmacy_list.dart';

class PharmacyDynamicList extends StatelessWidget {
  final int selectedIndex;
  final List<MedicineModel> medicines;

  const PharmacyDynamicList({
    super.key,
    required this.selectedIndex,
    required this.medicines,
  });

  @override
  Widget build(BuildContext context) {
    switch (selectedIndex) {
      case 0:
        return const PharmacyList();

      case 1:
        return MedicineList(medicines: medicines);

      case 2:
        return const NearbyList();

      default:
        return const SizedBox.shrink();
    }
  }
}
