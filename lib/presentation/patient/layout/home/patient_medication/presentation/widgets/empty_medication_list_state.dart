
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../core/resources/color_manager.dart';
import '../../../../../../../../core/resources/styles_manager.dart';

class EmptyMedicationListState extends StatelessWidget {
  final VoidCallback onAddPressed;

  const EmptyMedicationListState({
    super.key,
    required this.onAddPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 60.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 160.h,
              width: 160.w,
              decoration: BoxDecoration(
                color: ColorManager.primary.withAlpha(50),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.medication_outlined,
                size: 85.sp,
                color: ColorManager.primary,
              ),
            ),
            32.verticalSpace,
            Text(
              "No Medications Added Yet",
              style: getBoldStyle(
                color: ColorManager.black,
                fontSize: 24.sp,
              ),
              textAlign: TextAlign.center,
            ),
            12.verticalSpace,
            Text(
              "Start adding your medications to track\nyour daily schedule and get reminders",
              style: getMediumStyle(
                color: ColorManager.gray,
                fontSize: 16.sp,
              ),
              textAlign: TextAlign.center,
            ),
            50.verticalSpace,
            SizedBox(
              width: 240.w,
              height: 54.h,
              child: ElevatedButton.icon(
                onPressed: onAddPressed,
                icon: const Icon(Icons.add),
                label: Text(
                  "Add First Medication",
                  style: getBoldStyle(
                    color: Colors.white,
                    fontSize: 17.sp,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}