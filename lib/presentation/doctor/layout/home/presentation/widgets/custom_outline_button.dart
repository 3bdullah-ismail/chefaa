import 'package:flutter/material.dart';

import '../../../../../../core/resources/color_manager.dart';
import '../../../../../../core/resources/styles_manager.dart';
import '../../../../../../core/resources/values_manager.dart';

class CustomOutlineButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomOutlineButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        minimumSize: Size.zero,
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p10,
          vertical: AppPadding.p8,
        ),
        side: const BorderSide(color: ColorManager.primary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      onPressed: () {
        onPressed();
      },
      child: Row(
        children: [
          const Icon(Icons.add, color: ColorManager.primary, size: 23),
          Text(
            text,
            style: getMediumStyle(color: ColorManager.primary, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
