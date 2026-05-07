import 'package:chefaa/presentation/doctor/layout/home/presentation/widgets/clinic_card.dart';
import 'package:chefaa/presentation/doctor/layout/home/presentation/widgets/custom_outline_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/resources/color_manager.dart';
import '../../../../../../core/resources/styles_manager.dart';
import '../../../../../../core/resources/values_manager.dart';
import '../../../../../../core/widget/custom_app_bar.dart';

class DoctorHome extends StatelessWidget {
  const DoctorHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(170),
        child: CustomAppBar(
          isLayout: true,
          title1: "Good Morning !",
          title2: "Dr. Ahmed",
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p20,
            vertical: AppPadding.p32,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "My Clinics",
                    style: getBoldStyle(color: ColorManager.black, fontSize: 22),
                  ),
                  const Spacer(),
                  CustomOutlineButton(text: "Add Clinic", onPressed: () {}),
                ],
              ),
               10.verticalSpace,
              ClinicCard()
            ],
          ),
        ),
      ),
    );
  }
}
