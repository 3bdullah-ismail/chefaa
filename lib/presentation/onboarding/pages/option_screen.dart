import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/presentation/onboarding/widgets/next_button.dart';
import 'package:flutter/material.dart';
import '../../../core/resources/font_manager.dart';
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
