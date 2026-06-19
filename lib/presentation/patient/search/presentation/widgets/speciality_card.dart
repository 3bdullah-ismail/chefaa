import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/values_manager.dart';

class SpecialityCard extends StatelessWidget {
  final Map<String, String> item;

  const SpecialityCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context, item["specialityName"]);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: AppSize.s105.h,
            width: AppSize.s105.w,
            padding: const EdgeInsets.all(AppPadding.p8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.r10),
              color: ColorManager.white,
              boxShadow: [
                BoxShadow(
                  color: ColorManager.black.withValues(alpha: .1),
                  blurRadius: AppSize.s5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Image.asset(
              item["specialityImage"]!,
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.topCenter,
              fit: BoxFit.cover,
            ),
          ),
          Text(item["specialityName"]!, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
