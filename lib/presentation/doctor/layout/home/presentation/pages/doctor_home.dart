import 'package:chefaa/presentation/doctor/layout/home/presentation/widgets/clinic_card.dart';
import 'package:chefaa/presentation/doctor/layout/home/presentation/widgets/custom_outline_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/resources/assets_manager.dart';
import '../../../../../../core/resources/color_manager.dart';
import '../../../../../../core/resources/styles_manager.dart';
import '../../../../../../core/resources/values_manager.dart';
import '../../../../../../core/widget/custom_app_bar.dart';

class DoctorHome extends StatelessWidget {
  const DoctorHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        preferredHeight: 170.h,
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundImage: AssetImage(ImageAssets.doctor),
              backgroundColor: const Color(0xFFE8EFF7),
            ),
            20.horizontalSpace,
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Good Morning !",
                  style: getSemiBoldStyle(
                    color: ColorManager.white,
                    fontSize: 16.sp,
                  ),
                ),
                4.verticalSpace,
                Text(
                  "Dr. Ahmed",
                  style: getBoldStyle(
                    color: ColorManager.white,
                    fontSize: 18.sp,
                  ),
                ),
              ],
            ),
          ],
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
                    style: getBoldStyle(
                      color: ColorManager.black,
                      fontSize: 22,
                    ),
                  ),
                  const Spacer(),
                  CustomOutlineButton(text: "Add Clinic", onPressed: () {}),
                ],
              ),
              10.verticalSpace,
              ClinicCard(),
            ],
          ),
        ),
      ),
    );
  }
}
