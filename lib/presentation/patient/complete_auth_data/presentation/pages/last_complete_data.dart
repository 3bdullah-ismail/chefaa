import 'package:chefaa/core/widget/custom_text_field.dart';
import 'package:chefaa/core/widget/loading.dart';
import 'package:easy_localization/easy_localization.dart';
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
  final TextEditingController allergiesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<CompleteCubit, CompleteState>(
          listenWhen: (previous, current) =>
              previous.status != current.status ||
              previous.message != current.message,
          listener: (context, state) {
            if (!context.mounted) return;

            if (state.status == CompleteStatus.loading) {
              Loading.show(context);
            } else if (state.status == CompleteStatus.error) {
              Loading.hide(context);
              final message = state.message ?? 'Somethingwentwrong'.tr();
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(message)));
            } else if (state.status == CompleteStatus.success) {
              Loading.hide(context);
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutesNames.patientLayout,
                (route) => false,
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
              child: Column(
                children: [
                  50.verticalSpace,
                  Text(
                    "doyouhaveanyallergies".tr(),
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
                        child: BlocBuilder<CompleteCubit, CompleteState>(
                          buildWhen: (previous, current) =>
                              previous.allergies != current.allergies,
                          builder: (context, state) {
                            return ListView.separated(
                              itemCount: AppConstants.allergies.length,
                              separatorBuilder: (context, index) => Divider(
                                indent: 10.w,
                                endIndent: 12.w,
                                color: Colors.grey.shade300,
                                thickness: 2,
                                height: 0.h,
                              ),
                              itemBuilder: (context, index) {
                                final allergyKey = AppConstants.allergies[index];

                                final isSelected = state.allergies.contains(allergyKey);

                                return GestureDetector(
                                  onTap: () => context
                                      .read<CompleteCubit>()
                                      .toggleAllergy(allergyKey),
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
                                          color: Colors.black.withValues(alpha: 0.2),
                                          blurRadius: 4,
                                          offset: const Offset(0, 4),
                                        ),
                                      ]
                                          : [],
                                    ),
                                    child: Text(
                                      allergyKey.tr(),
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
                      text: "enterthenameofAllergies".tr(),
                    ),
                  ),
                  30.verticalSpace,
                  CustomBtn(
                    text: "finishSignUp".tr(),
                    onPressed: () async {
                      final cubit = CompleteCubit.get(context);
                      cubit.addCustomAllergy(allergiesController.text);
                      await cubit.completeSignUp();
                    },
                  ),
                  15.verticalSpace,
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
