import 'package:chefaa/core/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/resources/assets_manager.dart';

class SuccessItem extends StatelessWidget {
  const SuccessItem({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250.w,
      height: 400.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 15,
        children: [
          SvgPicture.asset(IconsAssets.doneIcon),
          Text("Success", style: TextStyle(
            color: ColorManager.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),),
          Text(
            "Your account has been successfully registered", style: TextStyle(
            color: ColorManager.gray,
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
          ),
            textAlign: TextAlign.center,
          ),
         70.verticalSpace
        ],
      ),

        );
    }
}
