import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/styles_manager.dart';

class NotificationCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;
  final DateTime dateTime;
  final String type;
  final bool isRead;
  final VoidCallback? onTap;

  const NotificationCard({
    super.key,
    required this.icon,
    required this.title,
    required this.body,
    required this.dateTime,
    required this.type,
    required this.isRead,
    this.onTap,
  });

  String _formatTime(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inMinutes < 1) {
      return "Just now";
    } else if (diff.inMinutes < 60) {
      return "${diff.inMinutes} min ago";
    } else if (diff.inHours < 24) {
      return "${diff.inHours} h ago";
    } else if (diff.inDays == 1) {
      return "Yesterday";
    } else if (diff.inDays < 7) {
      return "${diff.inDays} days ago";
    }

    return DateFormat("dd MMM • hh:mm a").format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20.r),
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 6.h),
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: isRead
                ? Colors.white
                : ColorManager.primary.withValues(alpha: .05),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: isRead
                  ? ColorManager.input
                  : ColorManager.primary.withValues(alpha: .35),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .04),
                blurRadius: 15,
                offset: const Offset(0, 5),
              )
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 54.w,
                height: 54.w,
                decoration: BoxDecoration(
                  color: ColorManager.primary.withValues(alpha: .12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: ColorManager.primary,
                  size: 26.sp,
                ),
              ),

              15.horizontalSpace,

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(
                      children: [

                        Expanded(
                          child: Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: getBoldStyle(
                              color: ColorManager.black,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),

                        if (!isRead)
                          Container(
                            width: 10.w,
                            height: 10.w,
                            margin: EdgeInsets.only(right: 8.w),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),

                        Text(
                          _formatTime(dateTime),
                          style: getRegularStyle(
                            color: ColorManager.gray,
                            fontSize: 11.sp,
                          ),
                        ),
                      ],
                    ),

                    5.verticalSpace,

                    Text(
                      type.toUpperCase(),
                      style: getSemiBoldStyle(
                        color: ColorManager.primary,
                        fontSize: 11.sp,
                      ),
                    ),

                    8.verticalSpace,

                    Text(
                      body,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: getRegularStyle(
                        color: ColorManager.gray,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}