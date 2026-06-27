import 'package:flutter/material.dart';
import '../../data/models/medicine_details_model.dart';
import 'specification_row.dart';

class BioChemSpecificationCard extends StatelessWidget {
  final MedicineInfoModel medicineInfo;

  const BioChemSpecificationCard({super.key, required this.medicineInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xffF1F5F9)),
      ),
      child: Column(
        children: [
          SpecificationRow(
            label: "Manufacturer",
            value: medicineInfo.manufacturer.isNotEmpty
                ? medicineInfo.manufacturer
                : "N/A",
            icon: Icons.business_rounded,
          ),
          const Divider(height: 24, color: Color(0xffF1F5F9)),
          SpecificationRow(
            label: "Concentration",
            value: medicineInfo.concentration.isNotEmpty
                ? medicineInfo.concentration
                : "N/A",
            icon: Icons.blur_on_rounded,
          ),
          const Divider(height: 24, color: Color(0xffF1F5F9)),
          SpecificationRow(
            label: "Prescription",
            value: medicineInfo.prescription.isNotEmpty
                ? medicineInfo.prescription
                : "Not Required",
            icon: Icons.assignment_turned_in_rounded,
          ),
          const Divider(height: 24, color: Color(0xffF1F5F9)),
          SpecificationRow(
            label: "Shelf Location",
            value: medicineInfo.shelf.isNotEmpty ? medicineInfo.shelf : "N/A",
            icon: Icons.grid_view_rounded,
          ),
        ],
      ),
    );
  }
}
