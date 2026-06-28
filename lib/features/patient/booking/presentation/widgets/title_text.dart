import 'package:flutter/material.dart';

import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/font_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';

class TitleText extends StatelessWidget {
  const TitleText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: getSemiBoldStyle(
        color: ColorManager.black,
        fontSize: FontSize.s20,
      ),
    );
  }
}
