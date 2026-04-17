import 'package:chefaa/core/resources/assets_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../../core/resources/color_manager.dart';

class SuggestCard extends StatelessWidget {
  const SuggestCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: ColorManager.lightGray,
        border: Border.all(color: ColorManager.lightBlue, width: 4),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withAlpha(60),
            blurRadius: 7,
            offset: const Offset(1, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: AppPadding.p12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset(SvgAssets.suggestIcon, height: 45),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Upcoming Dose",
                  style: getRegularStyle(
                    color: ColorManager.black,
                  ).copyWith(fontSize: 16),
                ),
                Text(
                  "Metformin 500mg at 8:00 PM (in 3 hours)",
                  style: getRegularStyle(
                    color: ColorManager.h2Color,
                  ).copyWith(fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
