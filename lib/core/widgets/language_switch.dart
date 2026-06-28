import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/values_manager.dart';

class LanguageSwitch extends StatelessWidget {
  const LanguageSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isArabic = context.locale.languageCode == 'ar';

    return Container(
      width: 130,
      height: 48,
      padding: const EdgeInsets.all(AppPadding.p6),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withAlpha(80),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildItem(
            context,
            title: "EN",
            selected: !isArabic,
            onTap: () => context.setLocale(const Locale('en')),
          ),
          _buildItem(
            context,
            title: "العربية",
            selected: isArabic,
            onTap: () => context.setLocale(const Locale('ar')),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(
    BuildContext context, {
    required String title,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.symmetric(horizontal: AppPadding.p2),
        decoration: BoxDecoration(
          color: selected ? ColorManager.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: ColorManager.black.withAlpha(80),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(20.r),
            onTap: onTap,
            child: Center(
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: getBoldStyle(
                  color: selected ? ColorManager.lightGray : ColorManager.black,
                  fontSize: 14.sp
                ),
                child: Text(title),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
