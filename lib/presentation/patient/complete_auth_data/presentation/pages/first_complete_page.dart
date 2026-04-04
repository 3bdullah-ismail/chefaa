import 'package:chefaa/core/widget/custom_btn.dart';
import 'package:chefaa/presentation/patient/complete_auth_data/presentation/pages/second_complete_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/values_manager.dart';
import '../../../../../core/widget/custom_text_field.dart';
import '../manager/complete_cubit.dart';
import '../widgets/complete_data_container.dart';
import '../../../../../core/widget/custom_calender.dart';
import '../../../../../core/widget/custom_dropdown_btn.dart';

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
              children: [
                CompleteDataContainer(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppPadding.p14,
                      vertical: AppPadding.p16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                          items: const ["Male", "Female"],
                          hintText: "Select Your Gender",
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
                          controller: birthController,
                          onDateSelected: (date) {
                            setState(() {
                              birthDate = date;
                            });
                          },
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
                          controller: weightController,
                          text: "Weight",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your weight';
                            }
                            return null;
                          },
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
                          controller: heightController,
                          text: "Height",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your height';
                            }
                            return null;
                          },
                        ),

                        23.verticalSpace,

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
                          controller: bloodTypeController,
                          text: "Blood Type with ( + or - )",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your blood type';
                            }
                            return null;
                          },
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
                      final cubit = CompleteCubit.get(context);

                      cubit.setBasicInfo(
                        weight: double.parse(weightController.text),
                        height: int.parse(heightController.text),
                        bloodType: bloodTypeController.text,
                        gender: gender,
                        birthDate: birthDate,
                      );

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: cubit,
                            child: const SecondCompletePage(),
                          ),
                        ),
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
