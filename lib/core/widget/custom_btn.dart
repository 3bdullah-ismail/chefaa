import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../extensions/build_ex.dart';
import '../resources/values_manager.dart';

class CustomBtn extends StatelessWidget {
  const CustomBtn({
    super.key,
    required this.text,
    required this.onPressed,
    this.isDisabled = false,
    this.isSmall = false,
  });

  final bool isSmall;
  final String text;
  final Function() onPressed;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: isSmall ? context.width * .26 : context.width * .9,
        child: CupertinoButton(
          disabledColor: ColorManager.gray,
          minimumSize: Size.zero,
          padding: EdgeInsets.symmetric(
            vertical: isSmall ? AppPadding.p12 : 16.h,
            horizontal: isSmall ? AppPadding.p10 : 0,
          ),
          color: ColorManager.primary,
          borderRadius: BorderRadius.circular(isSmall ? 35.r : 32.r),
          onPressed: isDisabled ? null : onPressed,
          child: Text(
            text,
            style: isSmall
                ? getMediumStyle(color: ColorManager.white, fontSize: 18)
                : getSemiBoldStyle(color: ColorManager.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
