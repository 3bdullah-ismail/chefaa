import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/styles_manager.dart';

class ItemContent extends StatelessWidget {
  const ItemContent({
    super.key,
    required this.image,
    this.text,
    this.widget,
    required this.onTap,
  });

  final String image;
  final String? text;
  final Widget? widget;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          SvgPicture.asset(image, height: 40, width: 40),
          16.horizontalSpace,
          widget ??
              Text(
                text!,
                style: getMediumStyle(color: ColorManager.black, fontSize: 16),
              ),
          const Spacer(),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            color: ColorManager.gray,
            size: 18,
          ),
        ],
      ),
    );
  }
}
