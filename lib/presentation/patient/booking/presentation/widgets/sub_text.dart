import 'package:flutter/material.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../core/resources/styles_manager.dart';

class SubText extends StatelessWidget {
  const SubText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: getRegularStyle(color: ColorManager.gray, fontSize: FontSize.s14),
    );
  }
}
