import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/resources/color_manager.dart';

class ClinicStatus extends StatelessWidget {
  final String status;

  const ClinicStatus({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35.h,
      decoration: BoxDecoration(
        color: status == "open" ? ColorManager.lightGreen : ColorManager.error,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.timelapse_outlined,
            color: ColorManager.white,
            size: 20,
          ),
          10.horizontalSpace,
          Text(
            status == "open"
                ? "Clinic Open Today : 08:00 AM - 02:00PM"
                : "Clinic Closed Today",
            style: getBoldStyle(color: ColorManager.white, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
