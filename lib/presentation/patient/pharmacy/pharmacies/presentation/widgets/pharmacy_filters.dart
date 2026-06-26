import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/resources/color_manager.dart';
import '../../../../../../core/resources/styles_manager.dart';

class PharmacyFilters extends StatelessWidget {
  final List<String> filters;
  final int selectedIndex;
  final Function(int) onChanged;

  const PharmacyFilters({
    super.key,
    required this.filters,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(filters.length, (index) {
        final isSelected = selectedIndex == index;

        return Expanded(
          child: GestureDetector(
            onTap: () => onChanged(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: EdgeInsets.only(right: index == 2 ? 0 : 10),
              height: 42.h,
              decoration: BoxDecoration(
                color: isSelected
                    ? ColorManager.primary
                    : ColorManager.lightGray,
                borderRadius: BorderRadius.circular(30.r),
                border: Border.all(
                  color: isSelected
                      ? ColorManager.primary
                      : Colors.grey.shade300,
                ),
              ),
              child: Center(
                child: Text(
                  filters[index],
                  style: getBoldStyle(
                    color: isSelected ? Colors.white : Colors.grey.shade700,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
