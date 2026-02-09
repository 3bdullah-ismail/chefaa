import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../extensions/build_ex.dart';

class CustomBtn extends StatelessWidget {
  const CustomBtn({super.key, required this.text, required this.onPressed});
  final String text;
  final Function() onPressed;
  final bool isDisabled = false;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: context.width * .9,
        child: CupertinoButton(
          disabledColor: ColorManager.gray,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          color: ColorManager.primary,
          borderRadius: BorderRadius.circular(32.r),
          onPressed: isDisabled ? null : onPressed,
          child: Text(
            text,
            style: getSemiBoldStyle(color: ColorManager.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
