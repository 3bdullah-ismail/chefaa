import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/presentation/patient/ai_lab/presentation/widgets/risk_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../data/models/Report_analysis.dart';

class ReportCard extends StatelessWidget {
  final ReportAnalysis report;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const ReportCard({
    super.key,
    required this.report,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final dangerScore = (report.data?.dangerScore ?? 0).toDouble();
    final riskLevel = RiskLevel.fromScore(dangerScore);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(16, 16, 8, 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: ColorManager.black.withAlpha(50), blurRadius: 10),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    report.data?.patientName ?? "Unknown",
                    style: getBoldStyle(
                      color: ColorManager.black,
                      fontSize: 18,
                    ),
                  ),
                  10.verticalSpace,
                  Text(
                    "Danger Score: ${report.data?.dangerScore ?? 0}",
                    style: getSemiBoldStyle(
                      color: ColorManager.error,
                      fontSize: 14,
                    ),
                  ),
                  10.verticalSpace,
                  Text(
                    "Risk Level: ${riskLevel.title}",
                    style: getSemiBoldStyle(
                      color: ColorManager.primary,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
