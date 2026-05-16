import 'package:chefaa/core/resources/assets_manager.dart';
import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/constants_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/routes/app_routes_names.dart';
import 'package:chefaa/presentation/onboarding/widgets/next_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/resources/font_manager.dart';
import '../../../core/resources/values_manager.dart';
import '../../../core/widget/app_bar_content.dart';
import '../../../core/widget/custom_app_bar.dart';
import '../widgets/option_card.dart';

class OptionScreen extends StatefulWidget {
  const OptionScreen({super.key});

  @override
  State<OptionScreen> createState() => _OptionScreenState();
}

class _OptionScreenState extends State<OptionScreen> {
  String? selectedRole;

  void onSelect(String role) {
    setState(() {
      selectedRole = role;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        preferredHeight: 150.h,
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
        child: const AppBarContent(),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                48.verticalSpace,
                Text(
                  "Choose who you are",
                  style: getBoldStyle(
                    color: ColorManager.black,
                    fontSize: FontSize.s24,
                  ),
                ),
                24.verticalSpace,
                OptionCard(
                  title: AppConstants.doctor,
                  image: ImageAssets.doctor,
                  isSelected: selectedRole == AppConstants.doctor,
                  onTap: () => onSelect(AppConstants.doctor),
                ),
                32.verticalSpace,

                OptionCard(
                  title: AppConstants.patient,
                  image: ImageAssets.patient,
                  isSelected: selectedRole == AppConstants.patient,
                  onTap: () => onSelect(AppConstants.patient),
                ),

                32.verticalSpace,

                OptionCard(
                  title: AppConstants.facility,
                  image: ImageAssets.drugs,
                  isSelected: selectedRole == AppConstants.facility,
                  onTap: () => onSelect(AppConstants.facility),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p60,
                    vertical: AppPadding.p48,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      NextButton(
                        isEnabled: selectedRole != null,
                        onTap: () {
                          if (selectedRole == AppConstants.doctor) {
                            Navigator.pushReplacementNamed(
                              context,
                              AppRoutesNames.docSignUp,
                              arguments: AppConstants.doctor.toLowerCase(),
                            );
                          } else if (selectedRole == AppConstants.patient) {
                            Navigator.pushReplacementNamed(
                              context,
                              AppRoutesNames.patientSignUp,
                              arguments: AppConstants.patient.toLowerCase(),
                            );
                          } else if (selectedRole == AppConstants.facility) {
                            Navigator.pushReplacementNamed(
                              context,
                              AppRoutesNames.facilityOption,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
