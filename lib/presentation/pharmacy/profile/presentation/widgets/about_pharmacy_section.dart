import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/font_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';

class AboutPharmacySection extends StatefulWidget {
  final String about;

  const AboutPharmacySection({super.key, required this.about});

  @override
  State<AboutPharmacySection> createState() => _AboutPharmacySectionState();
}

class _AboutPharmacySectionState extends State<AboutPharmacySection> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    // If text is short, don't show read more.
    final bool isLongText = widget.about.length > 150;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: ColorManager.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.info_outline_rounded,
                  color: ColorManager.primary,
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                "About Pharmacy",
                style: getBoldStyle(
                  color: Colors.black87,
                  fontSize: FontSize.s16.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            crossFadeState: _isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: Text(
              widget.about,
              style: getRegularStyle(
                color: Colors.grey.shade600,
                fontSize: FontSize.s14.sp,
              ).copyWith(height: 1.5),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            secondChild: Text(
              widget.about,
              style: getRegularStyle(
                color: Colors.grey.shade600,
                fontSize: FontSize.s14.sp,
              ).copyWith(height: 1.5),
            ),
          ),
          if (isLongText) ...[
            SizedBox(height: 8.h),
            GestureDetector(
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 4.h),
                child: Text(
                  _isExpanded ? "Read Less" : "Read More",
                  style: getSemiBoldStyle(
                    color: ColorManager.primary,
                    fontSize: FontSize.s13.sp,
                  ),
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }
}
