import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';
import 'package:chefaa/core/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/facility_ai_insight_widget.dart';
import '../widgets/facility_alert_banner_widget.dart';
import '../widgets/facility_dashboard_header_widget.dart';
import '../widgets/facility_quick_actions_widget.dart';
import '../widgets/facility_stat_cards_widget.dart';
import '../widgets/results_uploaded_widget.dart';
import '../widgets/today_requests_widget.dart';

class FacilityDashboardPage extends StatelessWidget {
  const FacilityDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        preferredHeight: AppSize.s116,
        borderRadiusValue: AppRadius.r28,
        child: FacilityDashboardHeaderWidget(),
      ),
      backgroundColor: ColorManager.lightGray,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: AppSize.s20.h),
                const FacilityStatCardsWidget(),
                SizedBox(height: 16.h),
                const FacilityAlertBannerWidget(),
                SizedBox(height: 16.h),
                const FacilityAiInsightWidget(),
                SizedBox(height: 24.h),
                const FacilityQuickActionsWidget(),
                SizedBox(height: 24.h),
                const TodayRequestsWidget(),
                SizedBox(height: 24.h),
                const ResultsUploadedWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
