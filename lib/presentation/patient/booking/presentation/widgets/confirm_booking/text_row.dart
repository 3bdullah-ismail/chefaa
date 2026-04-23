import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';

class TextRow extends StatelessWidget {
  const TextRow({super.key, required this.firstText, required this.secondText});

  final String firstText;
  final String secondText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          firstText,
          style: getMediumStyle(color: ColorManager.gray, fontSize: 13),
        ),
        Text(
          secondText,
          style: getMediumStyle(color: ColorManager.black, fontSize: 13),
        ),
      ],
    );
  }
}

