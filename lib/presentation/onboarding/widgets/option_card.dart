import 'package:chefaa/presentation/onboarding/widgets/selection_circle.dart'
    show SelectionCircle;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/resources/color_manager.dart';
import '../../../core/resources/font_manager.dart';
import '../../../core/resources/styles_manager.dart';

class OptionCard extends StatelessWidget {
  final String title;
  final String image;
  final bool isSelected;
  final VoidCallback onTap;

  const OptionCard({
    super.key,
    required this.title,
    required this.image,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        width: 270,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
        child: Row(
          children: [
            Image.asset(image, height: 120),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                title,
                style: getBoldStyle(
                  color: ColorManager.gray,
                  fontSize: FontSize.s22,
                ),
              ),
            ),
            SelectionCircle(isSelected: isSelected),
          ],
        ),
      ),
    );
  }
}
