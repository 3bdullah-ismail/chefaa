import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/resources/color_manager.dart';
import '../../../../../../core/resources/values_manager.dart';

class PatientCard extends StatelessWidget {
  final String name;
  final String lastVisit;
  final void Function() onTap;

  const PatientCard({
    super.key,
    required this.name,
    required this.lastVisit,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(50),
              spreadRadius: 1,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: getSemiBoldStyle(
                    color: ColorManager.black,
                    fontSize: 18,
                  ),
                ),
                15.verticalSpace,
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p8,
                    vertical: AppPadding.p2,
                  ),
                  decoration: BoxDecoration(
                    color: ColorManager.lawAnalysis.withAlpha(50),
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                  child: Text(
                    "Following Up",
                    style: getSemiBoldStyle(
                      color: ColorManager.lawAnalysis,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  lastVisit,
                  style: getRegularStyle(
                    color: ColorManager.gray,
                    fontSize: 16,
                  ),
                ),
                15.verticalSpace,
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p8,
                    vertical: AppPadding.p2,
                  ),
                  decoration: BoxDecoration(
                    color: ColorManager.lightBlue,
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                  child: Text(
                    "Upcoming",
                    style: getMediumStyle(
                      color: ColorManager.primary,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
