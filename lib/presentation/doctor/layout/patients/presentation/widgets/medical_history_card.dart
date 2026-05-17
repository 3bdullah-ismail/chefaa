import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/resources/color_manager.dart';
import '../../../../../../core/resources/styles_manager.dart';
import '../../../../../../core/resources/values_manager.dart';

class MedicalHistoryCard extends StatelessWidget {
  const MedicalHistoryCard({super.key});

  Widget _sectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: getBoldStyle(
          color: ColorManager.black,
          fontSize: 16.sp,
        ),
      ),
    );
  }

  Widget _chip(String text, Color color) {
    return Container(
      margin: const EdgeInsets.only(right: AppPadding.p8, bottom: AppPadding.p4,top: AppPadding.p8),
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12, vertical: AppPadding.p8),
      decoration: BoxDecoration(
        color: color.withAlpha(50),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Text(
        text,
        style: getBoldStyle(
          color: color,
          fontSize: 14.sp,
        ),
      ),
    );
  }

  Widget _wrapList(List<Widget> children) {
    return Wrap(
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(50),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle('Allergies'),
            _wrapList([
              _chip('Peanuts', ColorManager.primary),
              _chip('Penicillin', ColorManager.primary),
            ]),

            SizedBox(height: 16.h),

            _sectionTitle('Chronic Conditions'),
            _wrapList([
              _chip('Diabetes', ColorManager.lawAnalysis),
              _chip('Hypertension', ColorManager.lawAnalysis),
            ]),
          ],
        ),
      ),
    );
  }
}