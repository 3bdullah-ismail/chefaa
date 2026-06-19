import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../../../../../core/resources/color_manager.dart';
import '../../../../../../core/resources/styles_manager.dart';

class PharmacyHeader extends StatelessWidget {
  final String title;

  const PharmacyHeader({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: ColorManager.black,
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
    'View All',
          style:getMediumStyle(
            color: ColorManager.primary,
            fontSize: 16.sp,
          ).copyWith(
            decoration: TextDecoration.underline,
            decorationColor: ColorManager.primary,
            decorationThickness: 2,
          )
          ),
        ),
      ],
    );
  }
}