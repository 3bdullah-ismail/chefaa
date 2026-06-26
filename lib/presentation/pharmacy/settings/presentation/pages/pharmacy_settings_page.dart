import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chefaa/core/config/get_config.dart';
import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/widget/inside_app_bar.dart';
import 'package:chefaa/core/widget/loading.dart';
import '../manager/pharmacy_settings_cubit.dart';

class PharmacySettingsPage extends StatefulWidget {
  const PharmacySettingsPage({super.key});

  @override
  State<PharmacySettingsPage> createState() => _PharmacySettingsPageState();
}

class _PharmacySettingsPageState extends State<PharmacySettingsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<PharmacySettingsCubit>(
      create: (context) => getIt<PharmacySettingsCubit>()..loadSettingsStatus(),
      child: Scaffold(
        backgroundColor: const Color(0xffF6F7FB),
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(110),
          child: InsideAppBar(
            title: "Pharmacy Settings",
            subtitle: "Manage your pharmacy operation hours and status",
            isLayout: false,
          ),
        ),
        body: BlocConsumer<PharmacySettingsCubit, PharmacySettingsState>(
          buildWhen: (previous, current) {
            return current is PharmacySettingsLoadLoading ||
                current is PharmacySettingsLoadSuccess ||
                current is PharmacySettingsLoadError ||
                current is PharmacySettingsInitial;
          },
          listener: (context, state) {
            if (state is PharmacySettingsUpdateLoading) {
              Loading.show(context);
            } else if (state is PharmacySettingsUpdateSuccess) {
              Loading.hide(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.response.message ?? 'Status updated successfully'),
                  backgroundColor: ColorManager.lightGreen,
                ),
              );
            } else if (state is PharmacySettingsUpdateError) {
              Loading.hide(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  backgroundColor: ColorManager.error,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is PharmacySettingsLoadLoading || state is PharmacySettingsInitial) {
              return const Center(
                child: CircularProgressIndicator(
                  color: ColorManager.primary,
                ),
              );
            } else if (state is PharmacySettingsLoadError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline_rounded,
                        color: Colors.red.shade300,
                        size: 60.sp,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        state.errorMessage,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: () => context.read<PharmacySettingsCubit>().loadSettingsStatus(),
                        icon: const Icon(Icons.refresh_rounded),
                        label: const Text("Retry"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.primary,
                          foregroundColor: ColorManager.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            final bool openNow = (state as PharmacySettingsLoadSuccess).openNow;

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Store Status Settings",
                    style: getBoldStyle(color: ColorManager.black, fontSize: 18.sp),
                  ),
                  16.verticalSpace,

                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: ColorManager.white,
                      borderRadius: BorderRadius.circular(24.r),
                      border: Border.all(color: Colors.grey.shade100, width: 1.2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.02),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(
                                color: openNow
                                    ? Colors.green.withValues(alpha: 0.1)
                                    : Colors.red.withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.storefront_rounded,
                                color: openNow ? Colors.green : Colors.red,
                                size: 28.sp,
                              ),
                            ),
                            12.horizontalSpace,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    openNow ? "Open Now" : "Closed Now",
                                    style: getBoldStyle(
                                      color: openNow ? Colors.green : Colors.red,
                                      fontSize: 18.sp,
                                    ),
                                  ),
                                  4.verticalSpace,
                                  Text(
                                    "Status: ${openNow ? 'Accepting Orders' : 'Offline'}",
                                    style: getMediumStyle(
                                      color: ColorManager.gray,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Switch.adaptive(
                              value: openNow,
                              activeThumbColor: Colors.green,
                              activeTrackColor: Colors.green.withValues(alpha: 0.5),
                              onChanged: (val) {
                                context.read<PharmacySettingsCubit>().updateStatus(val);
                              },
                            ),
                          ],
                        ),
                        16.verticalSpace,
                        const Divider(height: 1, color: Color(0xFFF1F5F9)),
                        16.verticalSpace,
                        Text(
                          openNow
                              ? "Patients can see your pharmacy, order medicines, and request deliveries. Turn off if you are closed or unable to fulfill new orders."
                              : "Your pharmacy is temporarily closed. Patients will not be able to order medicines from your store until you toggle status to Open.",
                          style: getRegularStyle(
                            color: ColorManager.darkGray,
                            fontSize: 13.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
