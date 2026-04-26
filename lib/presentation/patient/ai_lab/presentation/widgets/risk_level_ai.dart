import 'package:chefaa/presentation/patient/ai_lab/presentation/widgets/risk_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/resources/values_manager.dart';

class RiskLevelAi extends StatelessWidget {
  final double dangerScore;

  const RiskLevelAi({
    super.key,
    required this.dangerScore,
  });

  @override
  Widget build(BuildContext context) {
    final riskLevel = RiskLevel.fromScore(dangerScore);
    return Container(
      height: 115.h,
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        color: ColorManager.lightGray,
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withAlpha(80),
            blurRadius: 10,
            offset: const Offset(1, 2),
          ),
        ],
        borderRadius: BorderRadius.circular(25.r),
        border: const Border(
          left: BorderSide(
            color: ColorManager.gold,
            width: 12,
          ),
        ),
      ),

      child: Row(
        children: [
          Icon(
            riskLevel.icon,
            color: ColorManager.gold,
            size: 45,
          ),

          15.horizontalSpace,

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  riskLevel.title,
                  style: getSemiBoldStyle(
                    color: ColorManager.black,
                    fontSize: 18,
                  ),
                ),

                5.verticalSpace,

                Text(
                  riskLevel.description,
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