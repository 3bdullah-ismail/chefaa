import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/font_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/resources/assets_manager.dart';

class AppointmentCard extends StatelessWidget {
  const AppointmentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: ColorManager.input),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withValues(alpha: .1),
            blurRadius: 4.r,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 27.r,
                child: Image.asset(ImageAssets.doctor),
              ),
              12.verticalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dr. Ali Ahmed',
                      style: getMediumStyle(
                        fontSize: FontSize.s18.sp,
                        color: ColorManager.black,
                      ),
                    ),
                    4.verticalSpace,
                    Text(
                      'Internal Medicine Specialist',
                      style: getMediumStyle(
                        fontSize: FontSize.s12.sp,
                        color: ColorManager.darkGray,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: REdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: ColorManager.greenOverlay,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  'Done',
                  style: getRegularStyle(
                    color: ColorManager.lightGreen,
                    fontSize: FontSize.s12.sp,
                  ),
                ),
              ),
            ],
          ),
          16.verticalSpace,
          const Divider(),
          _buildRow('Visit Type', 'Video Call'),
          _buildRow('Date', 'December 5, 2025'),
          const Divider(),
          _buildRow('Payment Method', 'Credit Card'),
          _buildRow(
            'Consultation Fee',
            '150 E£',
            valueColor: ColorManager.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildRow(
    String title,
    String value, {
    Color valueColor = ColorManager.black,
  }) {
    return Padding(
      padding: REdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: getMediumStyle(
              fontSize: FontSize.s12.sp,
              color: ColorManager.darkGray,
            ),
          ),
          Text(
            value,
            style: getMediumStyle(color: valueColor, fontSize: FontSize.s14.sp),
          ),
        ],
      ),
    );
  }
}
