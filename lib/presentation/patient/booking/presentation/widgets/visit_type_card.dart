import 'package:chefaa/presentation/patient/booking/presentation/widgets/sub_text.dart';
import 'package:chefaa/presentation/patient/booking/presentation/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/resources/color_manager.dart';

class VisitTypeCard extends StatelessWidget {
  const VisitTypeCard({
    super.key,
    required this.svgPath,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.isSelected,
  });

  final String svgPath;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 320.w,
        height: 130.h,
        padding: REdgeInsets.symmetric(horizontal: 16),
        decoration: ShapeDecoration(
          color: ColorManager.lightGray,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 2,
              color: isSelected ? ColorManager.primary : ColorManager.lightGray,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          shadows: [
            BoxShadow(
              color: ColorManager.black.withValues(alpha: 0.25),
              blurRadius: 4,
              offset: const Offset(0, 4),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              padding: const EdgeInsets.all(8),
              decoration: ShapeDecoration(
                color: isSelected ? ColorManager.primary : ColorManager.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 4,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: SvgPicture.asset(
                svgPath,
                colorFilter: ColorFilter.mode(
                  isSelected ? ColorManager.white : ColorManager.primary,
                  BlendMode.srcIn,
                ),
              ),
            ),
            12.horizontalSpace,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleText(text: title),
                  4.verticalSpace,
                  SubText(text: subtitle),
                ],
              ),
            ),
            isSelected
                ? Icon(Icons.done, color: ColorManager.primary, size: 40)
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
