import 'package:chefaa/core/widget/custom_btn.dart';
import 'package:chefaa/core/widget/custom_text_field.dart';
import 'package:chefaa/presentation/patient/complete_auth_data/presentation/widgets/complete_data_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/constants_manager.dart';
import '../../../../../core/resources/values_manager.dart';
import '../manager/complete_cubit.dart';
import 'last_complete_data.dart';

class SecondCompletePage extends StatefulWidget {
  const SecondCompletePage({super.key});

  @override
  State<SecondCompletePage> createState() => _SecondCompletePageState();
}

class _SecondCompletePageState extends State<SecondCompletePage> {
  List<String> selectedDiseases = [];
  final TextEditingController controller = TextEditingController();

  void _onSelectionChanged(String disease) {
    setState(() {
      if (selectedDiseases.contains(disease)) {
        selectedDiseases.remove(disease);
      } else {
        selectedDiseases.add(disease);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            50.verticalSpace,
            Text(
              "Do you have any chronic conditions?",
              style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w800),
              textAlign: TextAlign.center,
            ),
            40.verticalSpace,
            Expanded(
              child: CompleteDataContainer(
                isList: false,
                child: Padding(
                  padding: const EdgeInsets.only(top: AppPadding.p8),
                  child: ListView.separated(
                    itemCount: AppConstants.chronicDiseases.length,
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.grey.shade300,
                      thickness: 2,
                      height: 0.h,
                    ),
                    itemBuilder: (context, index) {
                      final disease = AppConstants.chronicDiseases[index];
                      final isSelected = selectedDiseases.contains(disease);
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
                                ? ColorManager.gray.withValues(alpha: 0.35)
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
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
              child: CustomTextField(
                controller: controller,
                text: "Enter the name of chronic diseases",
              ),
            ),
            30.verticalSpace,
            CustomBtn(
              text: "Continue",
              onPressed: () {
                final cubit = CompleteCubit.get(context);
                final input = controller.text.trim();
                final diseases = List<String>.from(selectedDiseases);
                if (input.isNotEmpty && !diseases.contains(input)) {
                  diseases.add(input);
                }
                cubit.setChronicDiseases(diseases);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: CompleteCubit.get(context),
                      child: const LastCompleteData(),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
