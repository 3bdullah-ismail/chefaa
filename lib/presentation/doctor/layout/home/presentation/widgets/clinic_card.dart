import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';
import 'package:chefaa/presentation/doctor/layout/home/presentation/widgets/clinic_days_avaliable.dart';
import 'package:chefaa/presentation/doctor/layout/home/presentation/widgets/clinic_info_card.dart';
import 'package:chefaa/presentation/doctor/layout/home/presentation/widgets/clinic_status.dart';
import 'package:chefaa/presentation/doctor/layout/home/presentation/widgets/schedule_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClinicCard extends StatelessWidget {
  const ClinicCard({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> days = [
      // "Saturday",
      // "Sunday",
      // "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
    ];
    return Container(
      height: 900.h,
      decoration: BoxDecoration(
        color: ColorManager.lightGray,
        borderRadius: BorderRadius.circular(25.r),
        boxShadow: [
          BoxShadow(
            color: ColorManager.gray.withAlpha(100),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p18,
          vertical: AppPadding.p20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Down Town Clinic",
                      style: getBoldStyle(
                        color: ColorManager.primary,
                        fontSize: 18,
                      ),
                    ),
                    5.verticalSpace,
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: ColorManager.gray,
                          size: 16,
                        ),
                        Text(
                          "Cairo, Egypt",
                          style: getMediumStyle(
                            color: ColorManager.gray,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p12,
                    vertical: AppPadding.p6,
                  ),
                  width: 70.w,
                  height: 30.h,
                  decoration: BoxDecoration(
                    color: ColorManager.lawAnalysis,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Text(
                    "Pending",
                    style: getMediumStyle(
                      color: ColorManager.black,
                      fontSize: 12,
                    ),
                  ),
                ),
                10.verticalSpace,
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 30.h,
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) =>
                        ClinicDaysAvailable(day: days[index]),
                    separatorBuilder: (_, _) => const SizedBox(width: 7),

                    itemCount: days.length,
                  ),
                ),
                10.verticalSpace,
              ],
            ),
            10.verticalSpace,
            const ClinicStatus(status: "close"),
            10.verticalSpace,
            Row(
              children: const [
                Expanded(
                  child: ClinicInfoCard(title: "Consultation", value: "120"),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: ClinicInfoCard(title: "Slot Duration", value: "120"),
                ),
              ],
            ),
            10.verticalSpace,
            Row(
              children: const [
                Expanded(
                  child: ClinicInfoCard(title: "Max Cases /Day ", value: "120"),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: ClinicInfoCard(title: "PER/Slot", value: "120"),
                ),
              ],
            ),
            10.verticalSpace,
            const ClinicInfoCard(
              title: "Today's Hours",
              value: "08:00 AM - 02:00 PM",
              isInfinity: true,
            ),
            10.verticalSpace,
            const ClinicInfoCard(
              title: "License",
              value: "1234567890",
              isInfinity: true,
            ),
            20.verticalSpace,
            Text(
              "Schedule",
              style: getBoldStyle(color: ColorManager.gray, fontSize: 18),
            ),
            20.verticalSpace,
            const ScheduleCard(day: "Sunday", time: "08:00 AM - 02:00 PM"),
            10.verticalSpace,
            const ScheduleCard(day: "Sunday", time: "08:00 AM - 02:00 PM"),
          ],
        ),
      ),
    );
  }
}
