import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/resources/values_manager.dart';

class AiTips extends StatelessWidget {
  final List<String> tips;

  const AiTips({super.key, required this.tips});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.h,
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        color: ColorManager.lightGray,
        borderRadius: BorderRadius.circular(25.r),
        border: Border.all(color: ColorManager.gold),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withAlpha(60),
            blurRadius: 10,
            offset: const Offset(2, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset("assets/images/star 1.png", height: 50.h, width: 50.w),

          15.horizontalSpace,

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "What can you do?",
                  style: getBoldStyle(color: ColorManager.black, fontSize: 18),
                ),

                10.verticalSpace,

                Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      tips.map((e) => " ➤  $e").join("\n"),
                      style: getRegularStyle(
                        color: ColorManager.black,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
