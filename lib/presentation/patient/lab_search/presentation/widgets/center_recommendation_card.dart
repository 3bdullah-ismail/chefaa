import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/resources/assets_manager.dart';
import '../../../../../../core/resources/color_manager.dart';
import '../../../../../../core/resources/styles_manager.dart';
import '../../data/remote/models/search_centers_response.dart';

class CenterRecommendationCard extends StatelessWidget {
  final CenterModel centerData;

  const CenterRecommendationCard({super.key, required this.centerData});

  String get _centerImage {
    if (centerData.facilityType?.toLowerCase() == 'lab') {
      return ImageAssets.labBackground;
    } else if (centerData.facilityType?.toLowerCase() == 'both') {
      return ImageAssets.mri;
    } else {
      return ImageAssets.xRay;
    }
  }

  @override
  Widget build(BuildContext context) {
    final String tag = centerData.badge ?? "";

    return Container(
      margin: EdgeInsets.only(bottom: 14.h),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: ColorManager.input, width: 1.w),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          PositionedDirectional(
            start: 0,
            top: 0,
            bottom: 0,
            child: Container(width: 5.w, color: tag.toTagTextColor),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 17.w,
              top: 12.w,
              right: 12.w,
              bottom: 12.w,
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Image.asset(
                    _centerImage,
                    width: 72.w,
                    height: 72.h,
                    fit: BoxFit.cover,
                  ),
                ),
                12.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        centerData.name ?? "",
                        style: getBoldStyle(
                          color: ColorManager.black,
                          fontSize: 16.sp,
                        ),
                      ),
                      4.verticalSpace,
                      Text(
                        centerData.distance ?? "Unknown",
                        style: getRegularStyle(
                          color: ColorManager.gray,
                          fontSize: 13.sp,
                        ),
                      ),
                      6.verticalSpace,
                      Row(
                        children: [
                          Icon(
                            Icons.star_rounded,
                            color: ColorManager.gold,
                            size: 16.sp,
                          ),
                          4.horizontalSpace,
                          Text(
                            (centerData.rating ?? 0.0).toString(),
                            style: getMediumStyle(
                              color: ColorManager.gray,
                              fontSize: 13.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (tag.isNotEmpty)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: tag.toTagBackgroundColor,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          tag,
                          style: getBoldStyle(
                            color: tag.toTagTextColor,
                            fontSize: 10.sp,
                          ),
                        ),
                      ),
                    22.verticalSpace,
                    Text(
                      "EGP ${centerData.minPrice ?? 0}",
                      style: getBoldStyle(
                        color: ColorManager.primary,
                        fontSize: 15.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

extension TagColorExtension on String {
  Color get toTagBackgroundColor {
    switch (toUpperCase()) {
      case 'NEAREST':
        return ColorManager.lightBlue100;
      case 'CHEAPEST':
        return ColorManager.green100;
      case 'TOP RATED':
        return ColorManager.amber100;
      case 'FASTEST':
        return ColorManager.mint100;
      default:
        return ColorManager.lightGray;
    }
  }

  Color get toTagTextColor {
    switch (toUpperCase()) {
      case 'NEAREST':
        return ColorManager.blue600;
      case 'CHEAPEST':
        return ColorManager.green600;
      case 'TOP RATED':
        return ColorManager.amber600;
      case 'FASTEST':
        return ColorManager.mint600;
      default:
        return ColorManager.darkGray;
    }
  }
}
