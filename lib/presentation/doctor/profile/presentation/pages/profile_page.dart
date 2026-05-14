import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widget/app_bar_content.dart';
import '../../../../../core/widget/custom_app_bar.dart';

class DoctorProfile extends StatelessWidget {
  const DoctorProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        preferredHeight: 150.h,
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
        child: AppBarContent(),
      ),
      body: const Center(child: Text('This is the Doctor Profile Page')),
    );
  }
}
