import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/styles_manager.dart';
import '../../../../core/widget/custom_text_btn.dart';

class NotHaveAccount extends StatelessWidget {
  final void Function() onPressed;

  const NotHaveAccount({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "dontHaveAccount".tr(),
          style: getBoldStyle(color: ColorManager.gray, fontSize: 18),
        ),
        CustomTextBtn(
          text: "signUp".tr(),
          onPressed: () {
            onPressed();
          },
          fontSize: 18,
        ),
      ],
    );
  }
}
