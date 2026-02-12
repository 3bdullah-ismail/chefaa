import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/resources/color_manager.dart';

class CustomDropDownBtn extends StatelessWidget {
  final String? Function(String?)? validator;
  final String? value;
  final ValueChanged<String?> onChanged;

  const CustomDropDownBtn({
    required this.validator,
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> genderItems = ['Male', 'Female'];

    return DropdownButtonFormField<String>(
      initialValue: value,
      isExpanded: true,
      elevation: 2,
      dropdownColor: Colors.white,
      borderRadius: BorderRadius.circular(12.r),
      menuMaxHeight: 160.h,
      alignment: AlignmentDirectional.centerStart,


      icon: Padding(
        padding: EdgeInsets.only(right: 12.w),
        child: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: ColorManager.gray,
          size: 24.w,
        ),
      ),

      decoration: InputDecoration(
        filled: true,
        fillColor: ColorManager.lightGray,
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        hintStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: ColorManager.gray.withOpacity(0.7),
        ),
      ),

      hint: const Text('Select Your Gender'),

      items: genderItems.map((item) {
        final bool isSelected = value == item;

        return DropdownMenuItem<String>(
          value: item,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 16.w),
            decoration: BoxDecoration(
              color: isSelected
                  ? ColorManager.primary.withOpacity(0.08)
                  : null,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    item,
                    style: TextStyle(
                      fontSize: 15.5.sp,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                      color: isSelected
                          ? ColorManager.primary
                          : ColorManager.black.withOpacity(0.85),
                      height: 1.35,
                    ),
                  ),
                ),
                if (isSelected)
                  Icon(
                    Icons.check_rounded,
                    color: ColorManager.primary,
                    size: 20.w,
                  ),
              ],
            ),
          ),
        );
      }).toList(),

      selectedItemBuilder: (BuildContext context) {
        return genderItems.map((item) {
          return Align(
            alignment: AlignmentDirectional.centerStart,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: Text(
                item,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: ColorManager.gray,
                  letterSpacing: 0.2,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          );
        }).toList();
      },

      onChanged: onChanged,

      validator: validator,

      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: ColorManager.gray,
      ),
    );
  }
}