import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/presentation/patient/layout/home/patient_medication/presentation/widgets/outline_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../../core/resources/assets_manager.dart';
import '../../../../../../../core/resources/color_manager.dart';
import '../../../../../../../core/resources/values_manager.dart';

class MedicationCard extends StatelessWidget {
  final void Function() onPressed;

  const MedicationCard({super.key, required this.onPressed});

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
                    "Metformin",
                    style: getSemiBoldStyle(
                      color: ColorManager.black,
                    ).copyWith(fontSize: 18),
                  ),
                  Text(
                    "500 mg . Tablet",
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
                  "92%",
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
                "2x daily:08:00 AM, 08:00 PM",
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
                "Since Nov 1, 2025• Continuous",
                style: getRegularStyle(
                  color: ColorManager.gray,
                ).copyWith(fontSize: 14),
              ),
            ],
          ),
          Row(
            children: [
              const Spacer(),
              // OutlinedButton(
              //   style: OutlinedButton.styleFrom(
              //     tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              //     padding: const EdgeInsets.symmetric(
              //       horizontal: AppPadding.p16,
              //       vertical: AppPadding.p2,
              //     ),
              //     minimumSize: Size.zero,
              //     side: const BorderSide(color: ColorManager.primary),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(25),
              //     ),
              //   ),
              //   onPressed: () {
              //     onPressed();
              //   },
              //   child: Text(
              //     "Edit",
              //     style: getRegularStyle(
              //       color: ColorManager.primary,
              //     ).copyWith(fontSize: 16),
              //   ),
              // ),
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
