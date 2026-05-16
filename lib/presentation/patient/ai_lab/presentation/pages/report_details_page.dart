import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';
import 'package:chefaa/core/widget/inside_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/Report_analysis.dart';
import '../widgets/ai_summary.dart';
import '../widgets/ai_tips.dart';
import '../widgets/health_indicator.dart';
import '../widgets/report_finding_items.dart';
import '../widgets/risk_level_ai.dart';

class ReportDetailsPage extends StatelessWidget {
  final ReportAnalysis report;

  const ReportDetailsPage({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    final findings = report.data?.findings ?? [];

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: InsideAppBar(title: "AI Lab Report Analysis"),
      ),

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p32,
            vertical: AppPadding.p28,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Report Findings",
                style: getSemiBoldStyle(
                  color: ColorManager.black,
                  fontSize: 20.sp,
                ),
              ),
              15.verticalSpace,
              Container(
                height: 250.h,
                padding: const EdgeInsets.all(AppPadding.p20),
                decoration: BoxDecoration(
                  color: ColorManager.lightGray,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: ColorManager.input),
                  boxShadow: [
                    BoxShadow(
                      color: ColorManager.black.withAlpha(40),
                      blurRadius: 8,
                    ),
                  ],
                ),

                child: ListView.separated(
                  itemCount: findings.length,
                  separatorBuilder: (_, _) =>
                      const Divider(color: ColorManager.input),
                  itemBuilder: (context, index) {
                    final item = findings[index];

                    return ReportFindingItems(
                      testName: item.testName ?? "",
                      value: item.result ?? 0,
                      status: item.status ?? "",
                      unit: item.unit ?? "",
                    );
                  },
                ),
              ),
              20.verticalSpace,
              Text(
                "Your health Indicator",
                style: getSemiBoldStyle(
                  color: ColorManager.black,
                  fontSize: 20.sp,
                ),
              ),
              20.verticalSpace,
              HealthIndicator(
                value: (report.data?.dangerScore ?? 0).toDouble(),
              ),
              20.verticalSpace,
              RiskLevelAi(
                dangerScore: (report.data?.dangerScore ?? 0).toDouble(),
              ),
              20.verticalSpace,
              AiSummary(summary: report.data?.summary ?? ""),
              20.verticalSpace,
              AiTips(tips: report.data?.tips ?? []),
            ],
          ),
        ),
      ),
    );
  }
}
