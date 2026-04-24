import 'package:chefaa/core/resources/assets_manager.dart';
import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/widget/custom_circle_avatar.dart';
import 'package:chefaa/presentation/patient/booking/presentation/manager/booking_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'confirm_booking_card_decoration.dart';
import 'text_row.dart';

class AppointmentCard extends StatelessWidget {
  const AppointmentCard({super.key, required this.provider});

  final BookingProvider provider;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: confirmBookingCardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CustomCircleAvatar(imagePath: ImageAssets.doctor),
              12.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      provider.selectedDoctor?.name ?? "No Doctor Selected",
                      style: getBoldStyle(
                        color: ColorManager.black,
                        fontSize: 16,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    4.verticalSpace,
                    Text(
                      provider.selectedDoctor?.specialty ?? "",
                      style: getMediumStyle(
                        color: ColorManager.gray,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          16.verticalSpace,
          const Divider(color: ColorManager.input),
          8.verticalSpace,

          TextRow(firstText: 'Visit Type', secondText: provider.getVisitType()),

          8.verticalSpace,

          TextRow(
            firstText: 'Date',
            secondText: DateFormat(
              'MMMM d, yyyy',
            ).format(provider.selectedDate),
          ),

          8.verticalSpace,

          TextRow(
            firstText: 'Time',
            secondText: provider.selectedTime ?? "--:--",
          ),

          8.verticalSpace,
          const Divider(color: ColorManager.input),
          8.verticalSpace,

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Consultation Fee',
                style: getMediumStyle(color: ColorManager.black, fontSize: 16),
              ),
              Text(
                '${provider.selectedDoctor?.price ?? 0} E£',
                style: getMediumStyle(
                  color: ColorManager.primary,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
