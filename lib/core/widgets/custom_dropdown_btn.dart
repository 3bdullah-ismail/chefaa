import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:chefaa/core/resources/color_manager.dart';

class CustomDropDownBtn extends StatelessWidget {
  final String? Function(String?)? validator;
  final String? value;
  final String hintText;
  final ValueChanged<String?>? onChanged;
  final List<String> items;

  const CustomDropDownBtn({
    this.validator,
    super.key,
    required this.value,
    required this.onChanged,
    required this.items,
    required this.hintText,
  });

  @override
  @override
  Widget build(BuildContext context) {
    //final List<String> genderItems = ['Male', 'Female'];

    return Theme(
      data: Theme.of(context).copyWith(focusColor: ColorManager.white),
      child: DropdownButtonFormField<String>(
        isExpanded: true,
        elevation: 2,
        dropdownColor: ColorManager.white,
        borderRadius: BorderRadius.circular(25),
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
          fillColor: onChanged == null
              ? ColorManager.lightGray.withValues(alpha: 0.5)
              : ColorManager.lightGray,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 16.h,
          ),
          hintStyle: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: ColorManager.darkGray,
          ),
        ),

        hint: Text(hintText),

        items: items.map((item) {
          final bool isSelected = value == item;

          return DropdownMenuItem<String>(
            value: item,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 16.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: isSelected ? ColorManager.primary.withAlpha(38) : null,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      item,
                      style: TextStyle(
                        fontSize: 15.5.sp,
                        fontWeight: isSelected
                            ? FontWeight.w800
                            : FontWeight.w500,
                        color: isSelected
                            ? ColorManager.primary
                            : ColorManager.black,
                        height: 1.35,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),

        selectedItemBuilder: (BuildContext context) {
          return items.map((item) {
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
          color: ColorManager.darkGray,
        ),
      ),
    );
  }
}
