import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/widget/custom_circle_avatar.dart';

class ChatbotLandingWidget extends StatelessWidget {
  final Function(String) onActionTap;

  const ChatbotLandingWidget({super.key, required this.onActionTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CustomCircleAvatar(
            imagePath: 'assets/images/bot.png',
            radius: 56,
          ),
          SizedBox(height: 16.h),
          Text(
            "👋 Welcome, I'm Chefaa Assistant",
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: ColorManager.black,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Text(
            "I'm here to help you get your medications and medical consultations easily.",
            style: TextStyle(
              fontSize: 14.sp,
              color: ColorManager.gray,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          Row(
            children: [
              Expanded(
                child: _buildActionCard(
                  icon: Icons.medication_liquid_outlined,
                  title: "Ask about medication",
                  onTap: () => onActionTap("I want to ask about a medication"),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: _buildActionCard(
                  icon: Icons.local_hospital_outlined,
                  title: "Talk to a pharmacist",
                  onTap: () => onActionTap("I want to talk to a pharmacist"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: ColorManager.lightBlue.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: ColorManager.lightBlue.withValues(alpha: 0.6),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: ColorManager.primary, size: 28.sp),
            SizedBox(height: 12.h),
            Text(
              title,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: ColorManager.primary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
