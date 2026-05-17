import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/presentation/doctor/layout/patients/presentation/widgets/details_card.dart';
import 'package:chefaa/presentation/doctor/layout/patients/presentation/widgets/medical_history_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/resources/color_manager.dart';
import '../../../../../../core/resources/values_manager.dart';

class PatientDataCard extends StatelessWidget {
  const PatientDataCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,

          children: [
            Text(
              "Contact Information",
              style: getBoldStyle(color: ColorManager.black, fontSize: 20.sp),
            ),
            15.verticalSpace,
             DetailsCard(
              items: [
                DetailItem(title: 'Full Name', value: 'Ganna Mohamed'),
                DetailItem(title: 'Phone', value: '+1 234 567 890'),
                DetailItem(title: 'Email', value: 'ganaa@gmail.com'),
                DetailItem(title: 'Address', value: '123 Main Street'),
              ],
            ),
            30.verticalSpace,
            Text(
              "Personal Information",
              style: getBoldStyle(color: ColorManager.black, fontSize: 20.sp),
            ),
            15.verticalSpace,
            DetailsCard(
              items: [
                DetailItem(title: 'Age', value: '28'),
                DetailItem(title: 'Gender', value: 'Female'),
                DetailItem(title: 'Blood Type', value: 'O+'),
                DetailItem(title: 'Weight', value: '70 kg'),
              ],
            ),
            30.verticalSpace,
            Text(
              "Medical History",
              style: getBoldStyle(color: ColorManager.black, fontSize: 20.sp),
            ),
            15.verticalSpace,
            const MedicalHistoryCard(),
            30.verticalSpace,
            Text(
              "Appointment History",
              style: getBoldStyle(color: ColorManager.black, fontSize: 20.sp),
            ),
            15.verticalSpace,

            DetailsCard(
              items: [
                DetailItem(title: 'Date', value: '16 May 2026'),
                DetailItem(title: 'Time', value: '10:30 AM'),
                DetailItem(title: 'Clinic', value: 'Al Noor Clinic'),
                DetailItem(title: 'Payment', value: 'Cash'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
