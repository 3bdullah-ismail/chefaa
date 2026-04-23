import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../../core/resources/assets_manager.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/widget/custom_circle_avatar.dart';
import '../manager/booking_provider.dart';
import 'doctor_model.dart';

class DoctorDataCard extends StatelessWidget {
  const DoctorDataCard({super.key, required this.doctorModel});
  final DoctorModel doctorModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColorManager.input),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomCircleAvatar(
                imagePath: ImageAssets.doctor,
                radius: 30,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctorModel.name,
                      style: getSemiBoldStyle(
                        color: ColorManager.black,
                        fontSize: 18,
                      ),
                    ),
                    4.verticalSpace,
                    Text(
                      doctorModel.specialty,
                      style: getMediumStyle(
                        color: ColorManager.gray,
                        fontSize: 14,
                      ),
                    ),
                    8.verticalSpace,

                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: ColorManager.gold,
                          size: 24,
                        ),
                        4.horizontalSpace,

                        Text(
                          doctorModel.rating,
                          style: getMediumStyle(
                            color: ColorManager.black,
                            fontSize: 14,
                          ),
                        ),
                        4.horizontalSpace,

                        Text(
                          "(${doctorModel.ratingCount})",
                          style: getMediumStyle(
                            color: ColorManager.gray,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                '${doctorModel.price} E£',
                style: getSemiBoldStyle(
                  color: ColorManager.primary,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(color: ColorManager.input, height: 1),
          ),
          GestureDetector(
            onTap: () {
              context.read<BookingProvider>().selectDoctorAndNext(doctorModel);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Book Now',
                  style: getSemiBoldStyle(
                    color: ColorManager.primary,
                    fontSize: 18,
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: ColorManager.primary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
