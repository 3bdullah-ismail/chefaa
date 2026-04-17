import 'package:chefaa/core/resources/values_manager.dart';
import 'package:flutter/material.dart';

import '../resources/color_manager.dart';
import '../resources/styles_manager.dart';

class InsideAppBar extends StatelessWidget {
  final String title;
  final String? subtitle;
  final double height;
  final bool isSpeciality;
  const InsideAppBar({
    super.key,
    this.isSpeciality = false,
    required this.title,
    this.subtitle,
    this.height = 150,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: isSpeciality
          ? ColorManager.lightGray
          : ColorManager.primary,
      elevation: 15,
      shadowColor: ColorManager.lightGray,
      toolbarHeight: height,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      title: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: isSpeciality ? ColorManager.black : ColorManager.white,
              size: 27,
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: AppPadding.p20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: getBoldStyle(
                    color: isSpeciality
                        ? ColorManager.black
                        : ColorManager.white,
                  ).copyWith(fontSize: 22),
                ),
                const SizedBox(height: 4),
                isSpeciality
                    ? const SizedBox()
                    : Text(
                        subtitle ?? "",
                        style: getRegularStyle(
                          color: ColorManager.white.withOpacity(0.80),
                        ).copyWith(fontSize: 13),
                      ),
              ],
            ),
          ),
        ],
      ),
      titleSpacing: 20,
    );
  }
}
