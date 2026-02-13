import 'package:flutter/cupertino.dart';

import '../resources/color_manager.dart';
import '../resources/styles_manager.dart';
import 'custom_text_btn.dart';

class AlreadyHaveAccount extends StatelessWidget {
  const AlreadyHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Do you already have an account?",
          style: getMediumStyle(color: ColorManager.black, fontSize: 14),
        ),
        CustomTextBtn(text: "Login", onPressed: () {}, fontSize: 14),
      ],
    );
  }
}
