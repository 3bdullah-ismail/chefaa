import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';

class NotificationSection extends StatelessWidget {
  final String title;

  const NotificationSection({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 20.h,
        bottom: 12.h,
      ),
      child: Text(
        title,
        style: getBoldStyle(
          color: ColorManager.black,
          fontSize: 18.sp,
        ),
      ),
    );
  }
}