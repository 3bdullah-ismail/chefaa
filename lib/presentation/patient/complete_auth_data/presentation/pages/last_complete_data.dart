import 'package:chefaa/core/widget/custom_text_field.dart';
import 'package:chefaa/core/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/constants_manager.dart';
import '../../../../../core/resources/values_manager.dart';
import '../../../../../core/routes/app_routes_names.dart';
import '../../../../../core/widget/custom_btn.dart';
import '../manager/complete_cubit.dart';

import '../widgets/complete_data_container.dart';

class LastCompleteData extends StatefulWidget {
  const LastCompleteData({super.key});

  @override
  State<LastCompleteData> createState() => _LastCompleteDataState();
}

class _LastCompleteDataState extends State<LastCompleteData> {
  List<String> selectedAllergies = [];
  final TextEditingController allergiesController = TextEditingController();

  void _onSelectionChanged(String disease) {
    setState(() {
      if (selectedAllergies.contains(disease)) {
        selectedAllergies.remove(disease);
      } else {
        selectedAllergies.add(disease);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<CompleteCubit, CompleteState>(
          listener: (context, state) {
            if (state is CompleteLoadingState) {
              Loading.show(context);
            }
            if (state is CompleteErrorState) {
              Loading.hide(context);
            }
            if (state is CompleteSuccessState) {
              Loading.hide(context);

              CompleteCubit.get(context).reset();

              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutesNames.patientLayout,
                (route) => false,
              );
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                50.verticalSpace,
                Text(
                  "Do you have any allergies?",
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.center,
                ),
                40.verticalSpace,
                Expanded(
                  child: CompleteDataContainer(
                    isList: false,
                    child: Padding(
                      padding: const EdgeInsets.only(top: AppPadding.p8),
                      child: ListView.separated(
                        itemCount: AppConstants.allergies.length,
                        separatorBuilder: (context, index) => Divider(
                          color: Colors.grey.shade300,
                          thickness: 2,
                          height: 0.h,
                        ),
                        itemBuilder: (context, index) {
                          final disease = AppConstants.allergies[index];
                          final isSelected = selectedAllergies.contains(
                            disease,
                          );

                          return GestureDetector(
                            onTap: () => _onSelectionChanged(disease),
                            child: Container(
                              width: double.infinity,
                              height: 50.h,
                              padding: EdgeInsets.symmetric(
                                vertical: 10.h,
                                horizontal: 16.w,
                              ),
                              margin: EdgeInsets.symmetric(vertical: 3.h),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? ColorManager.gray.withValues(alpha: 0.2)
                                    : ColorManager.transparent,
                                borderRadius: BorderRadius.circular(12.r),
                                boxShadow: isSelected
                                    ? [
                                        BoxShadow(
                                          color: Colors.black.withValues(
                                            alpha: 0.2,
                                          ),
                                          blurRadius: 4,
                                          offset: const Offset(0, 4),
                                        ),
                                      ]
                                    : [],
                              ),
                              child: Text(
                                disease,
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700,
                                  color: ColorManager.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                50.verticalSpace,
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p28,
                  ),
                  child: CustomTextField(
                    controller: allergiesController,
                    text: "Enter the name of Allergies",
                  ),
                ),
                30.verticalSpace,
                CustomBtn(
                  text: "Finish Sign Up",
                  onPressed: () {
                    final cubit = CompleteCubit.get(context);

                    final input = allergiesController.text.trim();
                    List<String> finalAllergies = List.from(selectedAllergies);

                    if (input.isNotEmpty && !finalAllergies.contains(input)) {
                      finalAllergies.add(input);
                    }

                    cubit.setAllergies(finalAllergies);
                    cubit.completeSignUp();
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
