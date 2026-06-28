import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/features/patient/lab_results/data/models/lab_results_response.dart';

class LabResultCard extends StatelessWidget {
  final LabResultItem item;
  final VoidCallback onViewPressed;
  final VoidCallback onNotesPressed;

  const LabResultCard({
    super.key,
    required this.item,
    required this.onViewPressed,
    required this.onNotesPressed,
  });

  IconData _getIconForTest(String? testName) {
    final name = (testName ?? '').toLowerCase();
    if (name.contains('blood')) return Icons.bloodtype_outlined;
    if (name.contains('urine')) return Icons.opacity_outlined;
    if (name.contains('scan') ||
        name.contains('x-ray') ||
        name.contains('radiology')) {
      return Icons.radio_button_checked_outlined;
    }
    return Icons.science_outlined;
  }

  Color _getColorForTest(String? testName) {
    final name = (testName ?? '').toLowerCase();
    if (name.contains('blood')) return Colors.redAccent;
    if (name.contains('urine')) return Colors.amber;
    if (name.contains('scan') ||
        name.contains('x-ray') ||
        name.contains('radiology')) {
      return Colors.purpleAccent;
    }
    return ColorManager.primary;
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return "Just now";
    try {
      final dateTime = DateTime.parse(dateStr);
      final months = [
        "Jan",
        "Feb",
        "Mar",
        "Apr",
        "May",
        "Jun",
        "Jul",
        "Aug",
        "Sep",
        "Oct",
        "Nov",
        "Dec",
      ];
      return "${dateTime.day} ${months[dateTime.month - 1]} ${dateTime.year}";
    } catch (_) {
      return dateStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    final testIcon = _getIconForTest(item.fileName);
    final themeColor = _getColorForTest(item.fileName);

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withValues(alpha: 0.04),
            blurRadius: 10.r,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: ColorManager.input.withValues(alpha: 0.5),
          width: 1.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: themeColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(testIcon, color: themeColor, size: 24.sp),
              ),
              12.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.fileName ?? 'Lab Report',
                      style: getBoldStyle(
                        color: ColorManager.black,
                        fontSize: 16.sp,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    4.verticalSpace,
                    Text(
                      item.labName ?? 'Laboratory',
                      style: getMediumStyle(
                        color: ColorManager.primary,
                        fontSize: 13.sp,
                      ),
                    ),
                    6.verticalSpace,
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          color: ColorManager.gray,
                          size: 12.sp,
                        ),
                        4.horizontalSpace,
                        Text(
                          _formatDate(item.uploadedAt),
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
          if (item.doctorNotes != null && item.doctorNotes!.isNotEmpty) ...[
            12.verticalSpace,
            Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: ColorManager.lightGray.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.chat_bubble_outline_rounded,
                    color: ColorManager.primary,
                    size: 14.sp,
                  ),
                  8.horizontalSpace,
                  Expanded(
                    child: Text(
                      item.doctorNotes!,
                      style: getRegularStyle(
                        color: ColorManager.darkGray,
                        fontSize: 12.sp,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
          16.verticalSpace,
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onNotesPressed,
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    side: BorderSide(
                      color: ColorManager.primary.withValues(alpha: 0.3),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                  ),
                  child: Text(
                    "Doctor Notes",
                    style: getBoldStyle(
                      color: ColorManager.primary,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ),
              12.horizontalSpace,
              Expanded(
                child: ElevatedButton(
                  onPressed: onViewPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "View Document",
                        style: getBoldStyle(
                          color: ColorManager.white,
                          fontSize: 12.sp,
                        ),
                      ),
                      4.horizontalSpace,
                      Icon(
                        Icons.open_in_new,
                        color: ColorManager.white,
                        size: 12.sp,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
