import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/color_manager.dart';

class SectionCard extends StatelessWidget {
  final String title;
  final bool isAlert;
  final Color iconColor;
  final List<Widget> children;

  const SectionCard({
    super.key,
    required this.title,
    required this.iconColor,
    required this.children,
    this.isAlert = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(80),
              blurRadius: 10,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: getBoldStyle(color: isAlert?ColorManager.error:ColorManager.lightGreen, fontSize: 18.sp),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView(
                children: children,
              ),
            ),
          ],
        ),
      ),
    );
  }
}