import 'package:chefaa/core/config/get_config.dart';
import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/font_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';
import 'package:chefaa/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:chefaa/features/facility/dashboard/presentation/manager/dashboard_cubit.dart';
import 'package:chefaa/features/facility/dashboard/presentation/widgets/facility_dashboard_header_widget.dart';
import 'package:chefaa/features/facility/dashboard/presentation/widgets/facility_quick_actions_widget.dart';
import 'package:chefaa/features/facility/dashboard/presentation/widgets/facility_stat_cards_widget.dart';
import 'package:chefaa/features/facility/dashboard/presentation/widgets/results_uploaded_widget.dart';
import 'package:chefaa/features/facility/dashboard/presentation/widgets/today_requests_widget.dart';

class FacilityDashboardPage extends StatelessWidget {
  final VoidCallback? onNavigateToServices;

  const FacilityDashboardPage({super.key, this.onNavigateToServices});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DashboardCubit>()..getDashboard(),
      child: Scaffold(
        appBar: const CustomAppBar(
          preferredHeight: AppSize.s116,
          borderRadiusValue: AppRadius.r28,
          child: FacilityDashboardHeaderWidget(),
        ),
        backgroundColor: ColorManager.lightGray,
        body: SafeArea(
          child: BlocBuilder<DashboardCubit, DashboardState>(
            builder: (context, state) {
              if (state is GetDashboardLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: ColorManager.primary),
                );
              } else if (state is GetDashboardFailure) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline_rounded,
                          color: ColorManager.red600,
                          size: 48.sp,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          state.errorMessage,
                          textAlign: TextAlign.center,
                          style: getBoldStyle(
                            color: ColorManager.black,
                            fontSize: FontSize.s16.sp,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        ElevatedButton(
                          onPressed: () {
                            context.read<DashboardCubit>().getDashboard();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorManager.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: const Text("Retry"),
                        ),
                      ],
                    ),
                  ),
                );
              }

              final response = context.read<DashboardCubit>().dashboardResponse;

              return RefreshIndicator(
                onRefresh: () => context.read<DashboardCubit>().getDashboard(),
                color: ColorManager.primary,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 24.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: AppSize.s20.h),
                        FacilityStatCardsWidget(
                          requestsCount: response?.pendingCount,
                          completedCount: response?.uploadedCount,
                        ),
                        SizedBox(height: 24.h),
                        FacilityQuickActionsWidget(
                          onServicesPressed: onNavigateToServices,
                        ),
                        SizedBox(height: 24.h),
                        TodayRequestsWidget(
                          pendingUploads: response?.pendingUploads,
                        ),
                        SizedBox(height: 24.h),
                        ResultsUploadedWidget(
                          uploadedResults: response?.uploadedResults,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}