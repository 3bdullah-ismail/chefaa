import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/resources/assets_manager.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/resources/values_manager.dart';
import '../../../../../core/widget/custom_circle_avatar.dart';
import '../../../booking/presentation/manager/booking_cubit.dart';
import '../../domain/entities/clinic_model.dart';

class SearchCard extends StatelessWidget {
  const SearchCard({super.key, required this.clinicModel});

  final ClinicModel clinicModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(AppRadius.r16),
        border: Border.all(color: ColorManager.input),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withValues(alpha: 0.05),
            blurRadius: AppSize.s10,
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
                radius: AppSize.s30,
              ),
              const SizedBox(width: AppSize.s12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      clinicModel.doctorName,
                      style: getSemiBoldStyle(
                        color: ColorManager.black,
                        fontSize: FontSize.s18,
                      ),
                    ),
                    AppSize.s4.verticalSpace,
                    Text(
                      clinicModel.doctorSpecialty,
                      style: getMediumStyle(
                        color: ColorManager.gray,
                        fontSize: FontSize.s14,
                      ),
                    ),
                    AppSize.s8.verticalSpace,

                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: ColorManager.gold,
                          size: AppSize.s24,
                        ),
                        AppSize.s4.horizontalSpace,

                        Text(
                          clinicModel.doctorRating,
                          style: getMediumStyle(
                            color: ColorManager.black,
                            fontSize: FontSize.s14,
                          ),
                        ),
                        AppSize.s4.horizontalSpace,

                        Text(
                          "(${clinicModel.doctorRatingCount})",
                          style: getMediumStyle(
                            color: ColorManager.gray,
                            fontSize: FontSize.s11,
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
                  fontSize: FontSize.s18,
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: AppPadding.p12),
            child: Divider(color: ColorManager.input, height: AppSize.s1),
          ),
          GestureDetector(
            onTap: () {
              final cubit = context.read<BookingCubit>();

              cubit.selectClinic(clinicModel);

              if (clinicModel.availableDays.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'This clinic has no available dates right now',
                    ),
                  ),
                );
                return;
              }

              cubit.nextStep();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Book Now',
                  style: getSemiBoldStyle(
                    color: ColorManager.primary,
                    fontSize: FontSize.s18,
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
