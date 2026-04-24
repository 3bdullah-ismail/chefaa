import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/presentation/patient/ai_lab/presentation/widgets/health_indicator.dart';
import 'package:chefaa/presentation/patient/ai_lab/presentation/widgets/report_finding_items.dart';
import 'package:chefaa/presentation/patient/ai_lab/presentation/widgets/risk_level_ai.dart';
import 'package:chefaa/presentation/patient/layout/home/presentation/widgets/ai_suggestion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/values_manager.dart';
import '../../../../../core/widget/custom_app_bar.dart';

class AILabAnalysis extends StatelessWidget {
  const AILabAnalysis({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: CustomAppBar(
          isSingleTitle: true,
          isLayout: true,
          title1: "AI Lab Report Analysis",
        ),
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
              20.verticalSpace,
              const ReportFindingItems(),
              20.verticalSpace,
              Text(
                "Your health Indicator",
                style: getSemiBoldStyle(
                  color: ColorManager.black,
                  fontSize: 20.sp,
                ),
              ),
              20.verticalSpace,
             const  HealthIndicator(),
              20.verticalSpace,
              const RiskLevelAi(),
              20.verticalSpace,
              const AiSuggestion(),
              20.verticalSpace,
              const AiSuggestion(),
            ],
          ),
        ),
      ),
    );
  }
}
