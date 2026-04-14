import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/resources/color_manager.dart';

class ProfileBottomSheet extends StatelessWidget {
  final Widget content;

  const ProfileBottomSheet({super.key, required this.content});

  static void show(BuildContext context, Widget content) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: false,
      backgroundColor: ColorManager.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (context) => ProfileBottomSheet(content: content),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        height: 0.85.sh,
        width: 1.sw,
        padding: EdgeInsets.only(
          top: 20.h,
          left: 20.w,
          right: 20.w,
          bottom: 20.h,
        ),
        child: Column(
          children: [
            Container(
              width: 134.w,
              height: 2.30.h,
              decoration: ShapeDecoration(
                color: const Color(0xFF232B43),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.r),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: REdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  child: content,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
