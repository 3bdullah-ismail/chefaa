import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/widget/custom_btn.dart';
import '../../../../../core/widget/custom_text_field.dart';
import 'item_container.dart';

class EditMedicalInformation extends StatefulWidget {
  const EditMedicalInformation({super.key});

  @override
  State<EditMedicalInformation> createState() => _EditMedicalInformationState();
}

class _EditMedicalInformationState extends State<EditMedicalInformation> {
  bool isReadOnly = true;
  String? gender;
  DateTime? birthDate;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    weightController.dispose();
    heightController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isReadOnly ? "Medical Information" : "Edit Medical Information",
                style: getSemiBoldStyle(
                  color: ColorManager.black,
                  fontSize: 20,
                ),
              ),
              if (isReadOnly)
                InkWell(
                  onTap: () {
                    setState(() {
                      isReadOnly = false;
                    });
                  },
                  child: SvgPicture.asset("assets/svg_images/edit.svg"),
                ),
            ],
          ),
          24.verticalSpace,
          ItemContainer(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Blood Type",
                    style: TextStyle(
                      color: ColorManager.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  12.verticalSpace,

                  CustomTextField(
                    completeData: true,
                    controller: nameController,
                    isReadOnly: isReadOnly,
                    text: "Blood Type with ( + or - )",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your blood type';
                      }
                      return null;
                    },
                  ),
                  16.verticalSpace,
                  const Text(
                    "Allegies",
                    style: TextStyle(
                      color: ColorManager.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  12.verticalSpace,

                  CustomTextField(
                    completeData: true,
                    controller: nameController,
                    isReadOnly: isReadOnly,
                    text: " ",
                  ),
                  16.verticalSpace,
                  const Text(
                    "Chronic conditions",
                    style: TextStyle(
                      color: ColorManager.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  12.verticalSpace,

                  CustomTextField(
                    completeData: true,
                    controller: nameController,
                    isReadOnly: isReadOnly,
                    text: " ",
                  ),
                  16.verticalSpace,
                ],
              ),
            ),
          ),
          32.verticalSpace,
          if (!isReadOnly)
            CustomBtn(
              text: "Save Changes",
              onPressed: () {
                setState(() {
                  isReadOnly = true;
                });
              },
            ),
        ],
      ),
    );
  }
}
