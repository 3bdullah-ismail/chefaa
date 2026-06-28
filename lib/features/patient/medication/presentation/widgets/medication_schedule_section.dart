import 'package:chefaa/features/patient/medication/presentation/widgets/date_section.dart';
import 'package:chefaa/features/patient/medication/presentation/widgets/switch_continous.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/constants_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/widgets/custom_dropdown_btn.dart';
import 'package:chefaa/features/patient/profile/presentation/widgets/item_container.dart';
import 'dose_card.dart';

class MedicationScheduleSection extends StatelessWidget {
  final List<TimeOfDay?> selectedTimes;
  final Function(int) deleteDose;
  final Function(int) onPickTime;
  final String hintText;
  final String? value;
  final void Function(String?) onChanged;
  final TextEditingController startDateController;
  final TextEditingController endDateController;
  final void Function(DateTime) onDateSelected;
  final Color color;
  final Alignment alignment;
  final void Function() onTap;

  const MedicationScheduleSection({
    super.key,
    required this.selectedTimes,
    required this.color,
    required this.alignment,
    required this.onTap,
    required this.deleteDose,
    required this.onPickTime,
    required this.hintText,
    required this.value,
    required this.onChanged,
    required this.startDateController,
    required this.endDateController,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ItemContainer(
      isMedication: true,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Schedule",
              style: getMediumStyle(fontSize: 18.sp, color: ColorManager.black),
            ),
            20.verticalSpace,

            Text(
              "Times per day",
              style: getMediumStyle(fontSize: 16.sp, color: ColorManager.black),
            ),
            8.verticalSpace,

            CustomDropDownBtn(
              items: AppConstants.timesPerDayItems,
              hintText: hintText,
              value: value,
              onChanged: (value) {
                onChanged(value);
              },
            ),

            18.verticalSpace,
            Text(
              "Dose Times",
              style: getMediumStyle(fontSize: 16.sp, color: ColorManager.black),
            ),
            12.verticalSpace,

            DoseCard(
              selectedTimes: selectedTimes,
              onPickTime: onPickTime,
              deleteDose: deleteDose,
            ),

            20.verticalSpace,

            Row(
              children: [
                Expanded(
                  child: DateSection(
                    label: "Start Date",
                    controller: startDateController,
                    onDateSelected: (DateTime p1) {
                      onDateSelected(p1);
                    },
                  ),
                ),
                12.horizontalSpace,
                Expanded(
                  child: DateSection(
                    label: "End Date",
                    controller: endDateController,
                    onDateSelected: (DateTime p1) {
                      onDateSelected(p1);
                    },
                  ),
                ),
              ],
            ),

            20.verticalSpace,

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Continuous medication",
                  style: getMediumStyle(
                    fontSize: 16.sp,
                    color: ColorManager.black,
                  ),
                ),
                SwitchContinous(
                  color: color,
                  alignment: alignment,
                  onTap: onTap,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
