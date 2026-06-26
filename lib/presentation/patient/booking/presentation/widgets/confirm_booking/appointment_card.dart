import 'package:chefaa/core/resources/assets_manager.dart';
import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/widget/custom_circle_avatar.dart';
import 'package:chefaa/presentation/patient/booking/presentation/manager/booking_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'confirm_booking_card_decoration.dart';
import 'text_row.dart';

class AppointmentCard extends StatelessWidget {
  const AppointmentCard({
    super.key,
    required this.cubit,
  });

  final BookingCubit cubit;

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
              const CustomCircleAvatar(
                imagePath: ImageAssets.doctor,
              ),
              12.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cubit.selectedClinic?.doctorName ??
                          "No Clinic Selected",
                      style: getBoldStyle(
                        color: ColorManager.black,
                        fontSize: 16,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    4.verticalSpace,
                    Text(
                      cubit.selectedClinic?.doctorSpecialty ?? "",
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

          TextRow(
            firstText: 'Visit Type',
            secondText:
            cubit.selectedVisitType == VisitType.online
                ? 'Video Call'
                : 'Clinic Visit',
          ),

          8.verticalSpace,

          TextRow(
            firstText: 'Date',
            secondText: cubit.selectedDate ?? '--',
          ),

          8.verticalSpace,

          TextRow(
            firstText: 'Time',
            secondText: cubit.selectedTime ?? '--:--',
          ),

          8.verticalSpace,
          const Divider(color: ColorManager.input),
          8.verticalSpace,

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Consultation Fee',
                style: getMediumStyle(
                  color: ColorManager.black,
                  fontSize: 16,
                ),
              ),
              Text(
                '${cubit.selectedClinic?.clinicPrice ?? 0} E£',
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