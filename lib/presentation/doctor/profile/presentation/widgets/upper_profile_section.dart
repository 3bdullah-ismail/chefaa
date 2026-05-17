import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/widget/custom_circle_avatar.dart';
import 'package:chefaa/presentation/doctor/profile/presentation/widgets/profile_stat_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/resources/assets_manager.dart';
import '../../../../patient/layout/home/presentation/manager/users_cubit.dart';
import '../../domain/entities/doctor_profile_entity.dart';

class UpperProfileSection extends StatelessWidget {
  final DoctorProfileEntity? doctorData;

  const UpperProfileSection({super.key, this.doctorData});

  static const double _headerSpacing = 30;
  static const double _statsContainerVerticalPadding = 15;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorManager.primary,
        borderRadius: BorderRadius.circular(40.r),
      ),
      padding: EdgeInsets.fromLTRB(20.w, 30.h, 20.w, 30.h),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50.r,
            backgroundColor: ColorManager.white.withValues(alpha: 0.3),
            child: CustomCircleAvatar(
              imagePath:
                  doctorData?.imageUrl != null &&
                      doctorData!.imageUrl!.isNotEmpty
                  ? doctorData!.imageUrl!
                  : ImageAssets.doctor,
              radius: 45.r,
              backgroundColor: ColorManager.white,
            ),
          ),
          16.verticalSpace,
          BlocBuilder<UsersCubit, UsersState>(
            builder: (context, state) {
              return Text(
                "Dr.${doctorData?.name ?? (state is UserLoaded ? state.user.name : "Doctor")}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: getBoldStyle(color: ColorManager.white, fontSize: 22.sp),
              );
            },
          ),
          4.verticalSpace,
          Text(
            doctorData?.specialization ?? "Specialization",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: getSemiBoldStyle(color: ColorManager.white, fontSize: 16.sp),
          ),
          12.verticalSpace,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
            decoration: BoxDecoration(
              border: Border.all(
                color: ColorManager.white.withValues(alpha: 0.5),
              ),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              doctorData?.location ?? "Location",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: getBoldStyle(color: ColorManager.white, fontSize: 14.sp),
            ),
          ),
          SizedBox(height: _headerSpacing.h),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: _statsContainerVerticalPadding.h,
            ),
            decoration: BoxDecoration(
              color: ColorManager.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: ColorManager.white.withValues(alpha: 0.2),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ProfileStatItem(
                  value: "${doctorData?.clinics ?? 0}",
                  label: "Clinics",
                ),
                const _VerticalDivider(),
                ProfileStatItem(
                  value: "${doctorData?.rating ?? 0.0}",
                  label: "Rating",
                ),
                const _VerticalDivider(),
                ProfileStatItem(
                  value: "${doctorData?.reviews ?? 0}",
                  label: "Reviews",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  const _VerticalDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.h,
      width: 1,
      color: ColorManager.white.withValues(alpha: 0.3),
    );
  }
}
