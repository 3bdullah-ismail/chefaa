import 'dart:io';

import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RadiologyCardWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final String price;
  final String duration;
  final bool isSwitchedOn;
  final ValueChanged<bool> onSwitchChanged;
  final String? imageOverlayBadge;

  const RadiologyCardWidget({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.duration,
    required this.isSwitchedOn,
    required this.onSwitchChanged,
    this.imageOverlayBadge,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: ColorManager.input.withValues(alpha: 0.8),
          width: 1.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                child: _buildImage(imageUrl),
              ),
              if (imageOverlayBadge != null)
                Positioned(
                  top: 10.h,
                  left: 10.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFC084FC).withValues(alpha: 0.85),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(
                      imageOverlayBadge!,
                      style: getBoldStyle(
                        color: ColorManager.white,
                        fontSize: 9.sp,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(14.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: getBoldStyle(
                              color: ColorManager.black,
                              fontSize: 14.sp,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            subtitle,
                            style: getRegularStyle(
                              color: ColorManager.gray,
                              fontSize: 11.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    CupertinoSwitch(
                      value: isSwitchedOn,
                      activeTrackColor: ColorManager.primary,
                      onChanged: onSwitchChanged,
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      price,
                      style: getBoldStyle(
                        color: ColorManager.black,
                        fontSize: 14.sp,
                      ),
                    ),
                    Text(
                      duration,
                      style: getRegularStyle(
                        color: ColorManager.gray,
                        fontSize: 11.sp,
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

  Widget _buildImage(String path) {
    if (path.startsWith('http') || path.startsWith('https')) {
      return Image.network(
        path,
        height: 120.h,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _errorWidget(),
      );
    } else if (path.isNotEmpty && (path.contains('/') || path.contains('\\'))) {
      return Image.file(
        File(path),
        height: 120.h,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _errorWidget(),
      );
    } else {
      return Image.asset(
        path.isEmpty ? 'assets/images/radiology_placeholder.png' : path,
        height: 120.h,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _errorWidget(),
      );
    }
  }

  Widget _errorWidget() {
    return Container(
      height: 120.h,
      width: double.infinity,
      color: ColorManager.lightBlue,
      child: Icon(
        Icons.image_rounded,
        color: ColorManager.primary,
        size: 30.sp,
      ),
    );
  }
}
