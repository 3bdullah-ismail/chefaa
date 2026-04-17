import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/assets_manager.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/styles_manager.dart';

class DoctorDataCard extends StatelessWidget {
  const DoctorDataCard({
    super.key,
    required this.doctorName,
    required this.spaciality,
    required this.rating,
    required this.ratingCount,
    required this.price,
  });
  final String doctorName;
  final String spaciality;
  final String rating;
  final String price;
  final String ratingCount;
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
              CircleAvatar(
                radius: 27,
                backgroundColor: Colors.transparent,
                child: ClipOval(
                  child: Image.asset(
                    ImageAssets.doctor,
                    width: 54,
                    height: 54,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctorName,
                      style: getSemiBoldStyle(
                        color: ColorManager.black,
                        fontSize: 18,
                      ),
                    ),
                    4.verticalSpace,
                    Text(
                      spaciality,
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
                          rating,
                          style: getMediumStyle(
                            color: ColorManager.black,
                            fontSize: 14,
                          ),
                        ),
                        4.horizontalSpace,

                        Text(
                          "($ratingCount)",
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
                '$price E£',
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Book Now',
                style: getSemiBoldStyle(
                  color: ColorManager.primary,
                  fontSize: 18,
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: ColorManager.primary),
            ],
          ),
        ],
      ),
    );
  }
}
