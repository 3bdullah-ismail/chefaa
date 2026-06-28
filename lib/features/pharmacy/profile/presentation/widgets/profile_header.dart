import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/font_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';

class ProfileHeader extends StatelessWidget {
  final String title;
  final String location;
  final bool openNow;
  final bool deliveryAvailable;
  final VoidCallback? onEditTap;

  const ProfileHeader({
    super.key,
    required this.title,
    required this.location,
    required this.openNow,
    required this.deliveryAvailable,
    this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorManager.primary,
            ColorManager.primary.withValues(alpha: 0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 32.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 72.w,
                    height: 72.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.15),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Icon(
                        Icons.local_pharmacy_rounded,
                        color: ColorManager.primary,
                        size: 32.sp,
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 4.h),
                        Text(
                          title,
                          style: getBoldStyle(
                            color: Colors.white,
                            fontSize: FontSize.s22.sp,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 6.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.location_on_rounded,
                              color: Colors.white70,
                              size: 16.sp,
                            ),
                            SizedBox(width: 4.w),
                            Expanded(
                              child: Text(
                                location,
                                style: getMediumStyle(
                                  color: Colors.white.withValues(alpha: 0.9),
                                  fontSize: FontSize.s13.sp,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (onEditTap != null) ...[
                    SizedBox(width: 8.w),
                    Material(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: const CircleBorder(),
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        onTap: onEditTap,
                        child: Padding(
                          padding: EdgeInsets.all(8.w),
                          child: Icon(
                            Icons.edit_rounded,
                            color: Colors.white,
                            size: 20.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              SizedBox(height: 24.h),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: [
                  _buildStatusBadge(
                    isActive: openNow,
                    activeText: "Open Now",
                    inactiveText: "Closed",
                    activeColor: Colors.green.shade400,
                    inactiveColor: Colors.red.shade400,
                    icon: Icons.access_time_filled_rounded,
                  ),
                  if (deliveryAvailable)
                    _buildFeatureBadge(
                      text: "Delivery Available",
                      icon: Icons.delivery_dining_rounded,
                      color: Colors.orange.shade400,
                    ),
                  _buildFeatureBadge(
                    text: "Verified",
                    icon: Icons.verified_rounded,
                    color: Colors.blue.shade400,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge({
    required bool isActive,
    required String activeText,
    required String inactiveText,
    required Color activeColor,
    required Color inactiveColor,
    required IconData icon,
  }) {
    final color = isActive ? activeColor : inactiveColor;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 14.sp),
          SizedBox(width: 4.w),
          Text(
            isActive ? activeText : inactiveText,
            style: getSemiBoldStyle(
              color: color,
              fontSize: FontSize.s12.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureBadge({
    required String text,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 14.sp),
          SizedBox(width: 4.w),
          Text(
            text,
            style: getMediumStyle(
              color: Colors.white,
              fontSize: FontSize.s12.sp,
            ),
          ),
        ],
      ),
    );
  }
}
