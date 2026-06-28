import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:chefaa/core/resources/color_manager.dart';

class CompleteDataContainer extends StatelessWidget {
  final bool isList;
  final Widget child;

  const CompleteDataContainer({
    super.key,
    required this.child,
    this.isList = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350.w,
      padding: isList
          ? const EdgeInsets.symmetric(horizontal: 16, vertical: 10)
          : null,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.r),
        color: ColorManager.lightGray,
        boxShadow: const [
          BoxShadow(
            color: ColorManager.gray,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: child,
    );
  }
}
