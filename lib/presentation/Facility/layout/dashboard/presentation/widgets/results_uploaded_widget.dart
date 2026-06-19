import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/routes/app_routes_names.dart';
import 'uploaded_result_item_widget.dart';

class ResultsUploadedWidget extends StatelessWidget {
  const ResultsUploadedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "RESULTS UPLOADED",
              style: getBoldStyle(
                color: ColorManager.gray.withValues(alpha: 0.8),
                fontSize: 12.sp,
              ).copyWith(letterSpacing: 0.5),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AppRoutesNames.facilityResults);
              },
              child: Text(
                "History",
                style: getBoldStyle(
                  color: ColorManager.primary,
                  fontSize: 12.sp,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 14.h),
        const UploadedResultItemWidget(
          name: "Hassan Gamal",
          scanType: "Chest CT Scan",
          time: "08:45 AM",
        ),
        const UploadedResultItemWidget(
          name: "Dina Farouk",
          scanType: "Abdominal Ultrasound",
          time: "07:30 AM",
        ),
      ],
    );
  }
}
