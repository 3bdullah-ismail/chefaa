import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/presentation/onboarding/widgets/next_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:msh_checkbox/msh_checkbox.dart';

import '../../../core/resources/font_manager.dart';
import '../../../core/widget/custom_app_bar.dart';

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
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(175),
        child: CustomAppBar(),
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 48),
              Text(
                "Choose who you are",
                style: getBoldStyle(
                  color: ColorManager.black,
                  fontSize: FontSize.s24,
                ),
              ),
              const SizedBox(height: 24),

              OptionCard(
                title: "Doctor",
                image: "assets/images/doctor.png",
                isSelected: selectedRole == "Doctor",
                onTap: () => onSelect("Doctor"),
              ),

              const SizedBox(height: 32),

              OptionCard(
                title: "Patient",
                image: "assets/images/patient.png",
                isSelected: selectedRole == "Patient",
                onTap: () => onSelect("Patient"),
              ),

              const SizedBox(height: 32),

              OptionCard(
                title: "Facility",
                image: "assets/images/drugs.png",
                isSelected: selectedRole == "Facility",
                onTap: () => onSelect("Facility"),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  NextButton(
                    isEnabled: selectedRole != null,
                    onTap: () {
                      if (selectedRole == "Doctor") {
                        Navigator.pushNamed(context, "/doctor_onboarding");
                      } else if (selectedRole == "Patient") {
                        Navigator.pushNamed(context, "/patient_onboarding");
                      } else if (selectedRole == "Facility") {
                        Navigator.pushNamed(context, "/facility_onboarding");
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OptionCard extends StatelessWidget {
  final String title;
  final String image;
  final bool isSelected;
  final VoidCallback onTap;

  const OptionCard({
    super.key,
    required this.title,
    required this.image,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        width: 270,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32.r),
          color: ColorManager.lightGray,
          boxShadow: [
            BoxShadow(
              color: ColorManager.gray,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset(image, height: 120),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                title,
                style: getBoldStyle(
                  color: ColorManager.gray,
                  fontSize: FontSize.s22,
                ),
              ),
            ),
            MSHCheckbox(
              size: 17,
              value: isSelected,
              colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                checkedColor: Colors.blue,
              ),
              style: MSHCheckboxStyle.fillFade,
              onChanged: (_) => onTap(),
            ),
          ],
        ),
      ),
    );
  }
}
