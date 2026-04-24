import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/assets_manager.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/resources/values_manager.dart';

class RiskLevelAi extends StatelessWidget {
  const RiskLevelAi({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 115.h,
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        color: ColorManager.lightGray,
        borderRadius: BorderRadius.circular(25.r),

        // left accent border
        border: const Border(
          left: BorderSide(
            color: ColorManager.gold,
            width: 12,
          ),
        ),

        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withAlpha(80),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: Row(
        children: [
          Image.asset(
            ImageAssets.riskLevel,
            height: 50.h,
            width: 50.w,
          ),

          15.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Risk Level",
                  style: getSemiBoldStyle(
                    color: ColorManager.black,
                    fontSize: 18,
                  ),
                ),

                5.verticalSpace,

                Text(
                  '''Stay consistent with your medications—small daily habits make a big difference in your long-term health.''',
                  style: getRegularStyle(
                    color: ColorManager.black,
                    fontSize: 12,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}