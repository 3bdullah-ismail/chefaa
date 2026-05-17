import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/styles_manager.dart';

class ItemColumn extends StatelessWidget {
  const ItemColumn({super.key, required this.text, required this.subText});

  final String text;
  final String subText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: getSemiBoldStyle(color: ColorManager.black, fontSize: 15),
        ),
        4.verticalSpace,
        Text(
          subText,
          textAlign: TextAlign.start,
          style: getRegularStyle(color: ColorManager.gray, fontSize: 12),
        ),
      ],
    );
  }
}
