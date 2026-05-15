import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../core/resources/assets_manager.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/widget/custom_circle_avatar.dart';
import '../../../booking/presentation/manager/booking_provider.dart';
import '../../domain/entities/clinic_model.dart';

class SearchCard extends StatelessWidget {
  const SearchCard({super.key, required this.clinicModel});

  final ClinicModel clinicModel;

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
                      clinicModel.doctorName,
                      style: getSemiBoldStyle(
                        color: ColorManager.black,
                        fontSize: 18,
                      ),
                    ),
                    4.verticalSpace,
                    Text(
                      clinicModel.doctorSpecialty,
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
                          clinicModel.doctorRating,
                          style: getMediumStyle(
                            color: ColorManager.black,
                            fontSize: 14,
                          ),
                        ),
                        4.horizontalSpace,

                        Text(
                          "(${clinicModel.doctorRatingCount})",
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
                '${clinicModel.clinicPrice} E£',
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
              final provider = context.read<BookingProvider>();
              final canProceed = provider.selectClinicAndNext(clinicModel);

              if (!canProceed) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('This clinic has no available dates right now'),
                  ),
                );
              }
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
