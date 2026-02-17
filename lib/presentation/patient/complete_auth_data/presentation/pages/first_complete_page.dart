import 'package:chefaa/core/widget/custom_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/values_manager.dart';
import '../../../../../core/routes/app_routes_names.dart';
import '../../../../../core/widget/custom_text_field.dart';
import '../widgets/complete_data_container.dart';
import '../widgets/custom_calender.dart';
import '../widgets/custom_dropdown_btn.dart';

class FirstCompletePage extends StatefulWidget {
  const FirstCompletePage({super.key});

  @override
  State<FirstCompletePage> createState() => _FirstCompletePageState();
}

class _FirstCompletePageState extends State<FirstCompletePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController bloodTypeController = TextEditingController();
  final TextEditingController birthController = TextEditingController();

  String? gender;
  DateTime? birthDate;

  @override
  void dispose() {
    weightController.dispose();
    heightController.dispose();
    bloodTypeController.dispose();
    birthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p32,
            vertical: AppPadding.p48,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CompleteDataContainer(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppPadding.p14,
                      vertical: AppPadding.p16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        20.verticalSpace,
                        const Text(
                          "Gender",
                          style: TextStyle(
                            color: ColorManager.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        12.verticalSpace,
                        CustomDropDownBtn(
                          value: gender,
                          onChanged: (value) {
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

                        23.verticalSpace,
                        const Text(
                          "Date of Birth",
                          style: TextStyle(
                            color: ColorManager.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        12.verticalSpace,
                        CustomCalendarField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select your Birth Date';
                            }
                            return null;
                          },
                          initialDate: birthDate,
                          onDateSelected: (DateTime date) {
                            setState(() {
                              birthDate = date;
                            });
                          },
                          controller: birthController,
                        ),
                        23.verticalSpace,
                        const Text(
                          "Weight",
                          style: TextStyle(
                            color: ColorManager.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        12.verticalSpace,
                        CustomTextField(
                          suffixText: "kg",
                          completeData: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your weight';
                            }
                            return null;
                          },
                          controller: weightController,
                          text: "Weight",
                        ),
                        23.verticalSpace,
                        const Text(
                          "Height",
                          style: TextStyle(
                            color: ColorManager.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        12.verticalSpace,
                        CustomTextField(
                          suffixText: "cm",
                          completeData: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your height';
                            }
                            return null;
                          },
                          controller: heightController,
                          text: "Height",
                        ),
                        23.verticalSpace,
                        const Text(
                          "Blood Type ",
                          style: TextStyle(
                            color: ColorManager.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        12.verticalSpace,
                        CustomTextField(
                          completeData: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your blood type';
                            }
                            return null;
                          },
                          controller: bloodTypeController,
                          text: "Blood Type with ( + or - )",
                        ),
                      ],
                    ),
                  ),
                ),
                50.verticalSpace,
                CustomBtn(
                  text: "Continue",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pushReplacementNamed(
                        context,
                        AppRoutesNames.patientSignUpCompleteChronicDiseases,
                        arguments: [
                          double.parse(weightController.text),
                          int.parse(heightController.text),
                          bloodTypeController.text,
                          gender?.toLowerCase(),
                          birthDate,
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
