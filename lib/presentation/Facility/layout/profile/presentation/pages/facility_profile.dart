import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';
import 'package:chefaa/core/widget/custom_app_bar.dart';
import 'package:chefaa/presentation/Facility/layout/profile/presentation/widgets/ai_visibility_section.dart';
import 'package:chefaa/presentation/Facility/layout/profile/presentation/widgets/facility_info_section.dart';
import 'package:chefaa/presentation/Facility/layout/profile/presentation/widgets/facility_profile_header_section.dart';
import 'package:chefaa/presentation/Facility/layout/profile/presentation/widgets/location_section.dart';
import 'package:chefaa/presentation/Facility/layout/profile/presentation/widgets/profile_stats_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FacilityProfilePage extends StatefulWidget {
  const FacilityProfilePage({super.key});

  @override
  State<FacilityProfilePage> createState() => _FacilityProfilePageState();
}

class _FacilityProfilePageState extends State<FacilityProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.lightGray,
      appBar: CustomAppBar(
        preferredHeight: AppSize.s140.h,
        borderRadiusValue: AppRadius.r24.r,
        padding: EdgeInsets.zero,
        child: FacilityProfileHeaderSection(
          title: 'Cairo MRI & Lab Center',
          location: 'Maadi, Cairo, Egypt',
          chips: const ['Lab', 'Radiology', 'Home service'],
          onEditPressed: () {},
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppPadding.p24.w,
              vertical: AppPadding.p12.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: AppSize.s24.h),
                const ProfileStatsSection(),
                SizedBox(height: AppSize.s20.h),
                const AiVisibilitySection(),
                SizedBox(height: AppSize.s24.h),
                const LocationSection(),
                SizedBox(height: AppSize.s20.h),
                const FacilityInfoSection(),
                SizedBox(height: AppSize.s24.h),

                SizedBox(height: AppSize.s24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
