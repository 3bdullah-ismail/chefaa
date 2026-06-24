import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'data_block.dart';

class ActiveMonographContent extends StatelessWidget {
  final String selectedSection;

  const ActiveMonographContent({super.key, required this.selectedSection});

  @override
  Widget build(BuildContext context) {
    switch (selectedSection) {
      case "Clinical Actions":
        return const Column(
          children: [
            DataBlock(
              title: "Approved Therapeutic Indications",
              description:
                  "Indicated for the comprehensive systemic management of localized fever, general inflammation reduction, and acute structural muscle aches under strict clinical healthcare oversight protocols.",
            ),

            SizedBox(height: 12),

            DataBlock(
              title: "Administration & Modality Strategy",
              description:
                  "Ingest 1 tablet whole with water every 4 to 6 hours as clinically necessary. Maximum daily accumulation threshold must not exceed 4000mg under any circumstances.",
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

                  const Text(
                    "Contraindicated in cases of advanced hepatic insufficiency, localized renal impairment, or severe historic allergic hypersensitivity reactions to NSAID derivatives.",
                    style: TextStyle(
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
                  "Mild transient gastrointestinal standard adjustments, mild vertigo loops, or temporary dry mouth symptoms may develop in a small segment (< 2.4%) of verified clinical studies.",
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
