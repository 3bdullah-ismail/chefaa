import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/resources/values_manager.dart';

class ReportFindingItems extends StatelessWidget {
  final String testName;
  final num value;
  final String status;
  final String unit;

  const ReportFindingItems({
    super.key,
    required this.testName,
    required this.value,
    required this.status,
    required this.unit,
  });

  Color getStatusColor() {
    switch (status.toLowerCase()) {
      case "normal":
        return ColorManager.lightGreen;

      case "low":
        return ColorManager.lawAnalysis;

      case "high":
        return ColorManager.error;

      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = getStatusColor();

    return Padding(
      padding: const EdgeInsets.only(left: AppPadding.p16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [
              Expanded(
                child: Text(
                  testName,
                  style: getSemiBoldStyle(
                    color: ColorManager.black,
                    fontSize: 16.sp,
                  ),
                ),
              ),

              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.p14,
                  vertical: AppPadding.p8,
                ),
                decoration: BoxDecoration(
                  color: color.withAlpha(40),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Text(
                  status,
                  style: getBoldStyle(color: color).copyWith(fontSize: 15),
                ),
              ),
            ],
          ),

          Text(
            "$value  $unit",
            style: getMediumStyle(
              color: color,
              fontSize: 14.sp,
            ),
          ),

          5.verticalSpace,
        ],
      ),
    );
  }
}