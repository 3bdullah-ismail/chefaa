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
          const TextSpan(text: "I agree to the Docify "),
          TextSpan(
            text: "Terms of Service",
            style: getBoldStyle(
              color: ColorManager.primary,
              fontSize: 14,
            ).copyWith(decoration: TextDecoration.underline),
            // recognizer: TapGestureRecognizer()..onTap = () {},
          ),
          const TextSpan(text: " and "),
          TextSpan(
            text: "Privacy Policy",
            style: getBoldStyle(
              color: ColorManager.primary,
              fontSize: 14,
            ).copyWith(decoration: TextDecoration.underline),
            // recognizer: TapGestureRecognizer()..onTap = () {},
          ),
        ],
      ),
    );
  }
}
