import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/routes/app_routes_names.dart';
import 'package:chefaa/presentation/onboarding/widgets/next_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/resources/font_manager.dart';
import '../../../core/widget/custom_app_bar.dart';
import '../widgets/option_card.dart';

class FacilityOptionScreen extends StatefulWidget {
  const FacilityOptionScreen({super.key});
  @override
  State<FacilityOptionScreen> createState() => _FacilityOptionScreenState();
}

class _FacilityOptionScreenState extends State<FacilityOptionScreen> {
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
                "Choose Facility",
                style: getBoldStyle(
                  color: ColorManager.black,
                  fontSize: FontSize.s24,
                ),
              ),
              const SizedBox(height: 22),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OptionCard(
                      width: 330,
                      title: "Pharmacy",
                      image: "assets/images/drugs.png",
                      isSelected: selectedRole == "Pharmacy",
                      onTap: () => onSelect("Pharmacy"),
                    ),

                    OptionCard(
                      width: 330,
                      title: "Medical Lab /\nRadiology Center",
                      image: "assets/images/lab.png",
                      isSelected: selectedRole == "Lab",
                      onTap: () => onSelect("Lab"),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          NextButton(
                            isEnabled: selectedRole != null,
                            onTap: () {
                              if (selectedRole == "Lab") {
                                Navigator.pushReplacementNamed(
                                  context,
                                  AppRoutesNames.facilitySignUp,
                                );
                              } else if (selectedRole == "Pharmacy") {
                                Navigator.pushNamed(context, "/");
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 48.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
