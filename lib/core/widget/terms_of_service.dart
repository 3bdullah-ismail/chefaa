import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../resources/color_manager.dart';
import '../resources/styles_manager.dart';

class TermsOfService extends StatelessWidget {
  const TermsOfService({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: getMediumStyle(color: ColorManager.black, fontSize: 14),
        children: [
            TextSpan(text: "terms".tr()),
          TextSpan(
            text: "termSuccess".tr(),
            style: getBoldStyle(
              color: ColorManager.primary,
              fontSize: 14,
            ).copyWith(decoration: TextDecoration.underline),
          ),
          TextSpan(text: "and".tr()),
          TextSpan(
            text: "privacyPolicy".tr(),
            style: getBoldStyle(
              color: ColorManager.primary,
              fontSize: 14,
            ).copyWith(decoration: TextDecoration.underline),
          ),
        ],
      ),
    );
  }
}
