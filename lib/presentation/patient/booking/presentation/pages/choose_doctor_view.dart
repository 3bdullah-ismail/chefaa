import 'package:chefaa/presentation/patient/booking/presentation/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/choose_doctor/choose_doctor_filter_bar.dart';
import '../widgets/choose_doctor/choose_doctor_results_list.dart';
import '../widgets/choose_doctor/choose_doctor_search_bar.dart';
import '../widgets/sub_text.dart';

class ChooseDoctorView extends StatelessWidget {
  const ChooseDoctorView({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitleText(text: 'Choose Doctor'),
              4.verticalSpace,
              const SubText(text: 'Select your healthcare provider.'),
              16.verticalSpace,
              const ChooseDoctorSearchBar(),
              16.verticalSpace,
              const ChooseDoctorFilterBar(),
              16.verticalSpace,
              const Expanded(child: ChooseDoctorResultsList()),
            ],
          ),
        ),
      ),
    );
  }
}

