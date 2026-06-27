import 'package:chefaa/core/widget/custom_btn.dart';
import 'package:chefaa/presentation/patient/complete_auth_data/presentation/pages/second_complete_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/values_manager.dart';
import '../../../../../core/widget/custom_calender.dart';
import '../../../../../core/widget/custom_dropdown_btn.dart';
import '../../../../../core/widget/custom_text_field.dart';
import '../manager/complete_cubit.dart';
import '../widgets/complete_data_container.dart';

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

                         Text(
                          "gender".tr(),
                          style: const TextStyle(
                            color: ColorManager.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        12.verticalSpace,

                        BlocBuilder<CompleteCubit, CompleteState>(
                          buildWhen: (previous, current) =>
                              previous.gender != current.gender,
                          builder: (context, state) {
                            return CustomDropDownBtn(
                              items:  ["male".tr(), "female".tr()],
                              hintText: "selectYourGender".tr(),
                              value: state.gender,
                              onChanged: (value) {
                                context.read<CompleteCubit>().updateGender(
                                  value,
                                );
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'pleaseselectyourgender'.tr();
                                }
                                return null;
                              },
                            );
                          },
                        ),

                        23.verticalSpace,

                         Text(
                          "dateofBirth".tr(),
                          style: const TextStyle(
                            color: ColorManager.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        12.verticalSpace,

                        CustomCalendarField(
                          hintText: "selectDate ofBirth".tr(),
                          controller: birthController,
                          onDateSelected: (date) {
                            final formatted =
                                '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
                            context.read<CompleteCubit>().updateBirthDate(date);
                            birthController.text = formatted;
                          },
                        ),

                        23.verticalSpace,

                         Text(
                          "weight".tr(),
                          style: const TextStyle(
                            color: ColorManager.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        12.verticalSpace,

                        CustomTextField(
                          suffixText: "kg".tr(),
                          completeData: true,
                          controller: weightController,
                          text: "weight".tr(),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'pleaseenteryourweight'.tr();
                            }
                            return null;
                          },
                        ),

                        23.verticalSpace,

                         Text(
                          "height".tr(),
                          style: const TextStyle(
                            color: ColorManager.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        12.verticalSpace,

                        CustomTextField(
                          suffixText: "cm".tr(),
                          completeData: true,
                          controller: heightController,
                          text: "height".tr(),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'pleaseenter yourheight'.tr();
                            }
                            return null;
                          },
                        ),

                        23.verticalSpace,

                         Text(
                          "bloodType".tr(),
                          style: const TextStyle(
                            color: ColorManager.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        12.verticalSpace,

                        CustomTextField(
                          completeData: true,
                          controller: bloodTypeController,
                          text: "bloodTypewith( + or - )".tr(),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'pleaseenteryourbloodtype'.tr();
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
                  text: "continue".tr(),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final cubit = CompleteCubit.get(context);
                      final error = cubit.captureBasicInfo(
                        weightText: weightController.text,
                        heightText: heightController.text,
                        bloodTypeText: bloodTypeController.text,
                      );

                      if (error != null) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(error)));
                        return;
                      }

                      Navigator.push(
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
