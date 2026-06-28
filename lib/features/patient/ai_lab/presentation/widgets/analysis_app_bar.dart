import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';
import 'package:flutter/material.dart';

import 'package:chefaa/core/resources/color_manager.dart';

class AnalysisAppBar extends StatelessWidget {
  final String? title1;
  final void Function()? onPressed;

  const AnalysisAppBar({super.key, this.title1, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: ColorManager.lightGray.withValues(alpha: 5),
      elevation: 15,
      centerTitle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),

      title: Padding(
        padding: const EdgeInsets.only(top: AppPadding.p32),
        child: Text(
          title1 ?? "",
          style: getBoldStyle(color: ColorManager.black, fontSize: 26),
        ),
      ),
    );
  }
}
