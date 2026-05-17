import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrescriptionMiniCard extends StatelessWidget {
  final String prescriptionName;
  final void Function() onTap;
  final String date;

  const PrescriptionMiniCard({
    super.key,
    required this.prescriptionName,
    required this.onTap,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(50),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    prescriptionName,
                    style: getBoldStyle(
                      color: ColorManager.black,
                      fontSize: 16.sp,
                    ),
                  ),
                  10.verticalSpace,
                  Text(
                    date,
                    style: getSemiBoldStyle(
                      color: ColorManager.gray,
                      fontSize: 14.sp,
                    ),
                  ),
                  7.verticalSpace,

                  Text(
                    "3 medications",
                    style: getSemiBoldStyle(
                      color: ColorManager.primary,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.p4,
                  vertical: AppPadding.p4,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.withAlpha(50),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text("Completed",
                  style: getSemiBoldStyle(
                    color: Colors.green,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
