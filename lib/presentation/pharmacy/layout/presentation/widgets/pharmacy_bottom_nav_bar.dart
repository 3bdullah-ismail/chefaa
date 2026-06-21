import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/font_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';

class PharmacyBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const PharmacyBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppRadius.r24.r),
          topRight: Radius.circular(AppRadius.r24.r),
        ),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withValues(alpha: 0.04),
            blurRadius: AppSize.s10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(height: AppSize.s1.h, color: ColorManager.input),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: AppPadding.p12.h,
              horizontal: AppPadding.p8.w,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  index: 0,
                  icon: Icons.home_outlined,
                  label: 'Home',
                ),
                _buildNavItem(
                  index: 1,
                  icon: Icons.smart_toy_outlined,
                  label: 'Assistant',
                ),
                _buildNavItem(
                  index: 2,
                  icon: Icons.payments_outlined,
                  label: 'Finance',
                ),
                _buildNavItem(
                  index: 3,
                  icon: Icons.inventory_2_outlined,
                  label: 'Inventory',
                ),
                _buildNavItem(
                  index: 4,
                  icon: Icons.settings_outlined,
                  label: 'Settings',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required String label,
  }) {
    final isSelected = currentIndex == index;
    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppPadding.p16.w,
          vertical: AppPadding.p8.h,
        ),
        decoration: BoxDecoration(
          color: isSelected ? ColorManager.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.r16.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? ColorManager.white : ColorManager.primary,
              size: AppSize.s24.sp,
            ),
            SizedBox(height: AppSize.s4.h),
            Text(
              label,
              style: getMediumStyle(
                color: isSelected ? ColorManager.white : ColorManager.primary,
                fontSize: FontSize.s11.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
