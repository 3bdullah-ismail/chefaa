import 'package:chefaa/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/resources/color_manager.dart';
import '../../../../../../core/resources/styles_manager.dart';
import '../pages/pharmacy_details_page.dart';

class PharmacyCard extends StatelessWidget {
  final String name;
  final String location;
  final String distance;
  final String deliveryTime;
  final int medicinesCount;
  final double rating;
  final int reviewsCount;
  final bool isOpen;
  final bool acceptsRx;

  const PharmacyCard({
    super.key,
    required this.name,
    required this.location,
    required this.distance,
    required this.deliveryTime,
    required this.medicinesCount,
    required this.rating,
    required this.reviewsCount,
    required this.isOpen,
    required this.acceptsRx,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                PharmacyDetailsPage(
                  name: name,
                  location: location,
                  distance: distance,
                  deliveryTime: deliveryTime,
                  medicinesCount: medicinesCount,
                  rating: rating,
                  reviewsCount: reviewsCount,
                  isOpen: isOpen,
                  acceptsRx: acceptsRx,
                    lat: 30.0626,
                    lng: 31.3219,
                ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p16,
          vertical: AppPadding.p14,
        ),
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(25.r),
          boxShadow: [
            BoxShadow(
              color: ColorManager.black.withAlpha(80),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isOpen)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppPadding.p10,
                      vertical: AppPadding.p4,
                    ),
                    decoration: BoxDecoration(
                      color: ColorManager.lightGreen.withAlpha(50),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 6.w,
                          height: 6.h,
                          decoration: const BoxDecoration(
                            color: ColorManager.lightGreen,
                            shape: BoxShape.circle,
                          ),
                        ),
                        7.horizontalSpace,
                        Text(
                          'Open',
                          style: getBoldStyle(
                            color: ColorManager.lightGreen,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            10.verticalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: ColorManager.black,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              rating.toString(),
                              style: getBoldStyle(
                                color: ColorManager.black,
                                fontSize: 14.sp,
                              ),
                            ),
                            5.verticalSpace,
                            const Icon(
                              Icons.star_rounded,
                              color: ColorManager.gold,
                              size: 18,
                            ),
                          ],
                        ),
                        Text(
                          '($reviewsCount reviews)',
                          style: getMediumStyle(
                            color: ColorManager.gray,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                7.verticalSpace,
                Row(
                  children: [
                    const Icon(
                      Icons.place_rounded,
                      color: ColorManager.error,
                      size: 14,
                    ),
                    7.horizontalSpace,
                    Text(
                      '$location — $distance away',
                      style: const TextStyle(
                        fontSize: 13,
                        color: ColorManager.gray,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                15.verticalSpace,

                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildTag(
                      icon: Icons.access_time_filled_rounded,
                      label: deliveryTime,
                      bgColor: ColorManager.lightBlue.withAlpha(120),
                      textColor: ColorManager.primary,
                    ),
                    _buildTag(
                      icon: Icons.medication_rounded,
                      label: '$medicinesCount medicines',
                      bgColor: ColorManager.greenOverlay.withAlpha(40),
                      textColor: ColorManager.lightGreen,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag({
    required IconData icon,
    required String label,
    required Color bgColor,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p8,
        vertical: AppPadding.p6,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.h, color: textColor),
          10.horizontalSpace,
          Text(
            label,
            style: getBoldStyle(color: textColor, fontSize: 12.sp),
          ),
        ],
      ),
    );
  }
}
