import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'custom_text_field.dart';

class BottomSheetTextFieldItem extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final String hint;

  const BottomSheetTextFieldItem({
    super.key,
    required this.title,
    required this.controller,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: getMediumStyle(color: ColorManager.black, fontSize: 16.sp),
        ),
        8.verticalSpace,

        CustomTextField(controller: controller, text: hint),
      ],
    );
  }
}
