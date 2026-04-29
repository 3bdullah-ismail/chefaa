import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/resources/color_manager.dart';
import '../../../../../../core/resources/values_manager.dart';
import 'elevate_button.dart';

class MedicineCard extends StatelessWidget {
  const MedicineCard({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();

    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 80.h,
        maxHeight: 200.h,
      ),
      child: Container(
        padding: const EdgeInsets.all(AppPadding.p16),
        decoration: BoxDecoration(
          color: ColorManager.lightGray,
          borderRadius: BorderRadius.circular(25.r),
          boxShadow: [
            BoxShadow(color: ColorManager.black.withAlpha(80), blurRadius: 10),
          ],
        ),
        child: RawScrollbar(
          controller: _scrollController,
          thumbVisibility: true,
          thickness: 5,
          radius: const Radius.circular(10),
          trackVisibility: false,
          thumbColor: ColorManager.gray.withAlpha(80),
          minThumbLength: 30,
          child: ListView.separated(
            controller: _scrollController,
            shrinkWrap: true,
            itemCount:5,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(right: AppPadding.p8),
            itemBuilder: (_, _) => Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Metformin",
                        style: getBoldStyle(color: ColorManager.black)
                            .copyWith(fontSize: 18),
                      ),
                      5.verticalSpace,
                      Text("500mg - 8:00 AM",
                        style: getMediumStyle(color: ColorManager.gray)
                            .copyWith(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(AppPadding.p4),
                  decoration: BoxDecoration(
                    color: ColorManager.gray,
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                  child: const Icon(
                    Icons.access_time_rounded,
                    color: ColorManager.white,
                    size: 20,
                  ),
                ),
                20.horizontalSpace,
                ElevateButton(text: "Confirm", onPressed: () {}),
              ],
            ),
            separatorBuilder: (_, _) => const Divider(),
          ),
        ),
      ),
    );
  }
}
