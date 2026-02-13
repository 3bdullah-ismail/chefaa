import 'package:chefaa/core/widget/custom_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/values_manager.dart';
import '../../../../../core/routes/app_routes_names.dart';
import '../../../../../core/widget/custom_app_bar.dart';
import '../widgets/success_item.dart';

class SignUpCompletePage extends StatelessWidget {
  const SignUpCompletePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(175),
        child: CustomAppBar(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p32,
            vertical: AppPadding.p100,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             const  SuccessItem(),
              30.verticalSpace,
              CustomBtn(text: "Complete Your Data", onPressed: () {
                Navigator.pushReplacementNamed(context, AppRoutesNames.patientSignUpCompleteData);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
