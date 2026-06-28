import 'package:flutter/material.dart';

import 'package:chefaa/core/resources/color_manager.dart';

class InspectorBottomSheetContainer extends StatelessWidget {
  const InspectorBottomSheetContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 8, bottom: 18),
        height: 2.5,
        width: 150,
        decoration: BoxDecoration(
          color: ColorManager.black,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
