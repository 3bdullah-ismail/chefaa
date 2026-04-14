import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/widget/custom_btn.dart';
import '../../../../../core/widget/custom_calender.dart';
import '../../../../../core/widget/custom_dropdown_btn.dart';
import '../../../../../core/widget/custom_text_field.dart';
import 'item_container.dart';

class EditUserDetails extends StatefulWidget {
  const EditUserDetails({super.key});

  @override
  State<EditUserDetails> createState() => _EditUserDetailsState();
}

class _EditUserDetailsState extends State<EditUserDetails> {
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
                isReadOnly ? "Basic Details" : "Edit Basic Details",
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
                  Text(
                    "Name",
                    style: getMediumStyle(
                      color: ColorManager.black,
                      fontSize: 16,
                    ),
                  ),
                  8.verticalSpace,
                  CustomTextField(
                    controller: nameController,
                    text: "Name",
                    isReadOnly: isReadOnly,
                  ),
                  16.verticalSpace,
                  Text(
                    "Gender",
                    style: getMediumStyle(
                      color: ColorManager.black,
                      fontSize: 16,
                    ),
                  ),
                  8.verticalSpace,
                  CustomDropDownBtn(
                    items: const ["Male", "Female"],
                    hintText: "Select Your Gender",
                    value: gender,
                    onChanged: isReadOnly
                        ? null
                        : (value) {
                            setState(() {
                              gender = value;
                            });
                          },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select your gender';
                      }
                      return null;
                    },
                  ),
                  16.verticalSpace,
                  Text(
                    "Date of Birth",

                    style: getMediumStyle(
                      color: ColorManager.black,
                      fontSize: 16,
                    ),
                  ),
                  8.verticalSpace,
                  CustomCalendarField(
                    hintText: "Select Date of Birth",
                    controller: dateController,
                    isReadOnly: isReadOnly,
                    onDateSelected: (date) {
                      setState(() {
                        birthDate = date;
                      });
                    },
                  ),

                  16.verticalSpace,
                  Text(
                    "Weight",
                    style: getMediumStyle(
                      color: ColorManager.black,
                      fontSize: 16,
                    ),
                  ),
                  8.verticalSpace,
                  CustomTextField(
                    suffixText: "kg",
                    completeData: true,
                    controller: weightController,
                    text: "Weight",
                    isReadOnly: isReadOnly,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your weight';
                      }
                      return null;
                    },
                  ),

                  16.verticalSpace,
                  Text(
                    "Height",
                    style: getMediumStyle(
                      color: ColorManager.black,
                      fontSize: 16,
                    ),
                  ),
                  8.verticalSpace,
                  CustomTextField(
                    suffixText: "cm",
                    completeData: true,
                    controller: heightController,
                    text: "Height",
                    isReadOnly: isReadOnly,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your height';
                      }
                      return null;
                    },
                  ),
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
