import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/resources/color_manager.dart';
import '../../../../../../../core/resources/constants_manager.dart';
import '../../../../../../../core/resources/styles_manager.dart';
import '../../../../../../../core/widget/bottom_sheet_text_field_item.dart';
import '../../../../../../../core/widget/custom_dropdown_btn.dart';
import '../../../../../profile/presentation/widgets/item_container.dart';

class BasicInfoSection extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController dosageController;
  final TextEditingController formController;
  final String hintText;
  final String? values;
  final void Function(String?) onChanged;

  const BasicInfoSection({
    super.key,
    required this.hintText,
    required this.onChanged,
    required this.values,
    required this.nameController,
    required this.dosageController,
    required this.formController,
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
            BottomSheetTextFieldItem(
              title: "Medication Name",
              controller: nameController,
              hint: "e.g. Paracetamol",
            ),
            16.verticalSpace,
            BottomSheetTextFieldItem(
              title: "Dosage",
              controller: dosageController,
              hint: "e.g. 500mg",
            ),
            16.verticalSpace,
            Text(
              "Form",
              style: getMediumStyle(fontSize: 16.sp, color: ColorManager.black),
            ),
            8.verticalSpace,
            CustomDropDownBtn(
              items: AppConstants.formItems,
              hintText: hintText,
              value: values,
              onChanged: (String? value) {
                onChanged(value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
