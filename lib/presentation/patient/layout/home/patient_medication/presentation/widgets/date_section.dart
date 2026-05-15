import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/resources/color_manager.dart';
import '../../../../../../../core/resources/styles_manager.dart';
import 'medication_calender.dart';
class DateSection extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final void Function(DateTime) onDateSelected;

  const DateSection({
    super.key,
    required this.label,
    required this.controller,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: getMediumStyle(fontSize: 16.sp, color: ColorManager.black),
        ),
        12.verticalSpace,
        MedicationCalender(
          isMedication: true,
          controller: controller,
          hintText: "Select $label.toLowerCase()",
          onDateSelected: (date) {
            onDateSelected(date);
          },
        ),
      ],
    );
  }
}
