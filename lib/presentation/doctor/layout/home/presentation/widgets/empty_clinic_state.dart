import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/resources/color_manager.dart';
import '../../../../../../core/resources/styles_manager.dart';
import '../widgets/clinic_bottom_sheet.dart';

class EmptyClinicsState extends StatelessWidget {
  const EmptyClinicsState({super.key});

  void _openAddSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: ColorManager.lightGray,
      isScrollControlled: true,
      builder: (_) => const FractionallySizedBox(
        heightFactor: 0.92,
        child: ClinicBottomSheet(
          title: "Add Clinic",
          content: "Enter your clinic details for tracking.",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                Icons.medical_services_outlined,
                size: 85.sp,
                color: ColorManager.primary,
              ),
            ),
            32.verticalSpace,
            Text(
              "No Clinics Yet",
              style: getBoldStyle(color: ColorManager.black, fontSize: 26.sp),
              textAlign: TextAlign.center,
            ),
            12.verticalSpace,
            Text(
              "You haven't added any clinics yet.\nStart by adding your first clinic.",
              style: getMediumStyle(color: ColorManager.gray, fontSize: 16.sp),
              textAlign: TextAlign.center,
            ),
            50.verticalSpace,
            SizedBox(
              width: double.infinity,
              height: 54.h,
              child: ElevatedButton.icon(
                onPressed: () => _openAddSheet(context),
                icon: const Icon(Icons.add, color: Colors.white),
                label: Text(
                  "Add Your First Clinic",
                  style: getBoldStyle(color: Colors.white, fontSize: 18.sp),
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
