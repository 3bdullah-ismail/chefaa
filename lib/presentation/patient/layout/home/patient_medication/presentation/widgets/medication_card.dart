import 'package:chefaa/core/resources/constants_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/presentation/patient/layout/home/patient_medication/data/models/Medications.dart';
import 'package:chefaa/presentation/patient/layout/home/patient_medication/presentation/widgets/outline_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../../core/resources/assets_manager.dart';
import '../../../../../../../core/resources/color_manager.dart';
import '../../../../../../../core/resources/values_manager.dart';

class MedicationCard extends StatelessWidget {
  final List<Medications> medications;
  final int index;
  final void Function() onPressed;

  const MedicationCard({
    super.key,
    required this.index,
    required this.medications,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppPadding.p16),
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: ColorManager.lightGray,
        border: Border.all(color: ColorManager.input),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withAlpha(60),
            blurRadius: 7,
            offset: const Offset(1, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            spacing: 20,
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: ColorManager.black.withAlpha(23),
                      blurRadius: 5,
                      offset: const Offset(1.5, 2),
                    ),
                  ],
                ),
                child: SvgPicture.asset(SvgAssets.medicationIcon),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    medications[index].name?.isNotEmpty == true
                        ? medications[index].name![0].toUpperCase() +
                              medications[index].name!
                                  .substring(1)
                                  .toLowerCase()
                        : "Medication Name",
                    style: getSemiBoldStyle(
                      color: ColorManager.black,
                    ).copyWith(fontSize: 18),
                  ),
                  Text(
                    "${medications[index].dosage} - ${medications[index].form}",
                    style: getRegularStyle(
                      color: ColorManager.h2Color,
                    ).copyWith(fontSize: 14),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.p8,
                  vertical: AppPadding.p4,
                ),
                decoration: BoxDecoration(
                  color: ColorManager.lightGreen.withAlpha(90),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Text(
                  "${medications[index].adherencePercentage}%",
                  style: getBoldStyle(
                    color: ColorManager.lightGreen,
                  ).copyWith(fontSize: 15),
                ),
              ),
            ],
          ),
          30.verticalSpace,
          Row(
            spacing: 10,
            children: [
              const Icon(Icons.access_time_rounded, color: ColorManager.gray),
              Text(
                "${medications[index].timesPerDay}x daily - ${medications[index].schedule?.join(', ')}",
                style: getRegularStyle(
                  color: ColorManager.gray,
                ).copyWith(fontSize: 14),
              ),
            ],
          ),
          Row(
            spacing: 10,
            children: [
              const Icon(
                Icons.calendar_today_outlined,
                color: ColorManager.gray,
              ),

              Text(
                "${AppConstants.formatDate(medications[index].startDate)} - ${AppConstants.formatDate(medications[index].endDate)}",
                style: getRegularStyle(
                  color: ColorManager.gray,
                ).copyWith(fontSize: 14),
              ),
            ],
          ),
          Row(
            children: [
              const Spacer(),
              OutlineButton(
                onPressed: onPressed,
                title: "Edit",
                color: ColorManager.primary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
