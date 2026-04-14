import 'package:flutter/material.dart';

import '../../../../../../../core/resources/color_manager.dart';
import '../../../../../../../core/resources/styles_manager.dart';
import '../../../../../../../core/resources/values_manager.dart';

class AddMedication extends StatelessWidget {
  final void Function() onTap;

  const AddMedication({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: ColorManager.primary,
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
      ),
      onPressed: () {
        onTap();
      },
      child: Row(
        children: [
          const Icon(Icons.add, size: 25, color: ColorManager.white),
          Text(
            "Add Medication ",
            style: getRegularStyle(
              color: ColorManager.white,
            ).copyWith(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
