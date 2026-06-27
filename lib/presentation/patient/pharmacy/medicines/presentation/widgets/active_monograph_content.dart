import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'data_block.dart';

class ActiveMonographContent extends StatelessWidget {
  final String selectedSection;
  final String indications;
  final String sideEffects;
  final String dosageInstructions;

  const ActiveMonographContent({
    super.key,
    required this.selectedSection,
    required this.indications,
    required this.sideEffects,
    required this.dosageInstructions,
  });

  @override
  Widget build(BuildContext context) {
    switch (selectedSection) {
      case "Clinical Actions":
        return Column(
          children: [
            DataBlock(
              title: "Approved Therapeutic Indications",
              description: indications.isNotEmpty
                  ? indications
                  : "No description available",
            ),
            const SizedBox(height: 12),
            DataBlock(
              title: "Administration & Modality Strategy",
              description: dosageInstructions.isNotEmpty
                  ? dosageInstructions
                  : "Take as directed by your doctor.",
            ),
          ],
        );

      case "Safety & Risks":
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xffFFF1F2),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xffFFE4E6)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.warning_amber_rounded,
                        size: 16,
                        color: Color(0xff9F1239),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Critical Contraindications",
                        style: getBoldStyle(
                          color: ColorManager.error,
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    sideEffects.isNotEmpty
                        ? sideEffects
                        : "No critical warnings reported. Use as directed.",
                    style: const TextStyle(
                      color: Color(0xffBE123C),
                      fontSize: 12,
                      height: 1.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const DataBlock(
              title: "Observed Adverse Reactions",
              description:
                  "None reported or mild transient gastrointestinal standard adjustments under common daily dosages.",
            ),
          ],
        );

      default:
        return const Column(
          children: [
            DataBlock(
              title: "Product Structural Summary",
              description:
                  "A precision formulated clinical molecular agent built to execute rapid structural symptom reduction while preserving normal organic metabolic functionality across target cellular tissue matrix lines.",
            ),
            SizedBox(height: 12),
            DataBlock(
              title: "Packaging Configuration",
              description:
                  "Supplied in standard medical grade double-foil PVC localized blister panels containing verified hermetically preserved stable units to secure absolute protection against air degradation loop systems.",
            ),
          ],
        );
    }
  }
}
