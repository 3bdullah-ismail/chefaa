import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/presentation/doctor/layout/patients/presentation/widgets/prescription_history_bottom_sheet.dart';
import 'package:chefaa/presentation/doctor/layout/patients/presentation/widgets/prescription_mini_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrescriptionHistory extends StatelessWidget {
  const PrescriptionHistory({super.key});

  final List<Map<String, dynamic>> prescriptions = const [
    {
      "date": "10 May 2026",
      "diagnosis": "Flu",
      "medications": [
        {
          "name": "Cetirizine",
          "dosage": "10 mg",
          "frequency": "Once daily at night",
          "duration": "10 days",
        },
        {
          "name": "Panadol",
          "dosage": "500 mg",
          "frequency": "Every 8 hours",
          "duration": "5 days",
        },
      ],
    },
    {
      "date": "5 May 2026",
      "diagnosis": "Headache",
      "medications": [
        {
          "name": "Brufen",
          "dosage": "400 mg",
          "frequency": "Twice daily",
          "duration": "3 days",
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      separatorBuilder: (context, index) =>  15.verticalSpace,
      padding: const EdgeInsets.all(16),
      itemCount: prescriptions.length,
      itemBuilder: (context, index) {
        final item = prescriptions[index];

        return PrescriptionMiniCard(
          prescriptionName: "Prescription ${index + 1}",
          date: item["date"] ?? "",
          onTap: () {
            final meds = (item["medications"] as List)
                .map((e) => Map<String, String>.from(e))
                .toList();

            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: ColorManager.lightGray,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              builder: (_) {
                return PrescriptionHistoryBottomSheet(
                  medications: meds,
                );
              },
            );
          },
        );
      },
    );
  }
}