import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../../../../../core/resources/color_manager.dart';
import '../../../../../../core/resources/styles_manager.dart';
import '../../../../../../core/resources/values_manager.dart';
import 'live_status_badge.dart';
import 'premium_card_decoration.dart';

class PharmacyHeaderCard extends StatelessWidget {
  final String name;
  final String location;
  final String distance;
  final bool isOpen;
  final bool acceptsRx;

  const PharmacyHeaderCard({
    super.key,
    required this.name,
    required this.location,
    required this.distance,
    required this.isOpen,
    required this.acceptsRx,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: premiumCardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(AppPadding.p14),
                decoration: BoxDecoration(
                  color: ColorManager.primary.withAlpha(20),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Icon(
                  Icons.local_hospital_rounded,
                  color: ColorManager.primary,
                  size: 32.h,
                ),
              ),

              14.horizontalSpace,

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: getBoldStyle(
                        color: ColorManager.black,
                        fontSize: 18.sp,
                      ),
                    ),

                    7.verticalSpace,

                    Row(
                      children: [
                        Icon(
                          Icons.place_rounded,
                          color: ColorManager.error,
                          size: 14.h,
                        ),

                        5.horizontalSpace,

                        Expanded(
                          child: Text(
                            "$location • $distance away",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: getBoldStyle(
                              color: ColorManager.gray,
                              fontSize: 13.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const Padding(
            padding: EdgeInsets.symmetric(
              vertical: AppPadding.p16,
            ),
            child: Divider(
              color: ColorManager.input,
              thickness: 0.5,
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LiveStatusBadge(isOpen: isOpen),

              if (acceptsRx)
                Row(
                  children: [
                    Icon(
                      Icons.gpp_good_rounded,
                      color: ColorManager.primary,
                      size: 18.h,
                    ),

                    5.horizontalSpace,

                    Text(
                      "Accepts Insurance & Rx",
                      style: getBoldStyle(
                        color: ColorManager.primary,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}