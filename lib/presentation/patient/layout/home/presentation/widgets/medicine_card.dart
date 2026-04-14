import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/widget/custom_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/resources/color_manager.dart';
import '../../../../../../core/resources/values_manager.dart';

class MedicineCard extends StatelessWidget {
  const MedicineCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        color: ColorManager.lightGray,
        borderRadius: BorderRadius.circular(25.r),
        boxShadow: [BoxShadow(
          color: ColorManager.black.withAlpha(80),
          blurRadius: 10,
        )]
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Metformin",
                  style: getBoldStyle(
                    color: ColorManager.black,
                  ).copyWith(fontSize: 18),
                ),
                5.verticalSpace,
                Text(
                  "500mg - 8:00 AM",
                  style: getMediumStyle(
                    color: ColorManager.gray,
                  ).copyWith(fontSize: 16),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(AppPadding.p4),
            decoration: BoxDecoration(
              color: ColorManager.gray,
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: const Icon(
              Icons.access_time_rounded,
              color: ColorManager.white,
            ),
          ),
          20.horizontalSpace,
          CustomBtn(isSmall: true, text: "Confirm", onPressed: () {}),
        ],
      ),
    );
  }
}
