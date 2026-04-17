import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/resources/color_manager.dart';
import '../../../../../../core/resources/styles_manager.dart';
import '../../../../../../core/resources/values_manager.dart';

class AiSuggestion extends StatelessWidget {
  const AiSuggestion({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
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
          Image.asset(
            "assets/images/star 1.png",
            fit: BoxFit.fill,
            height: 50.h,
            width: 50.w,
          ),
          15.horizontalSpace,
          Expanded(
            child: Text(
              '''Stay consistent with your medications—small daily habits make a big difference in your long-term health.''',
              style: getRegularStyle(color: ColorManager.black, fontSize: 15),
              textAlign: TextAlign.start,
              maxLines: 10,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
