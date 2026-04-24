import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/values_manager.dart';

class ReportFindingItems extends StatelessWidget {
  const ReportFindingItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 257.h,
      padding: const EdgeInsets.all(AppPadding.p20),
      decoration: BoxDecoration(
        color: ColorManager.lightGray,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: ColorManager.input, width: 1),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withAlpha(80),
            blurRadius: 10,
          ),
        ],
      ),
      child: ListView.separated(
        itemBuilder: (_, _) =>
        Column(
          spacing: 5,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Cholesterol",
                    style: getRegularStyle(
                      color: ColorManager.black,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
                 Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p14,
                    vertical: AppPadding.p4,
                  ),
                  decoration: BoxDecoration(
                    color: ColorManager.lightGreen.withAlpha(90),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text(
                    "high",
                    style: getBoldStyle(
                      color: ColorManager.lightGreen,
                    ).copyWith(fontSize: 15),
                  ),
                ),
              ],
            ),
             Text(
              "240 mg/dL",
              style: getRegularStyle(
                  color: ColorManager.error, fontSize: 14.sp),
            ),
            5.verticalSpace,
          ],
        ),
        separatorBuilder: (_, _) =>
        const Divider(color: ColorManager.input, thickness: 1),
        itemCount: 3,
      ),
    );
  }
}
