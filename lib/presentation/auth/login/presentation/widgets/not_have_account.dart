import 'package:flutter/cupertino.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/widget/custom_text_btn.dart';



class NotHaveAccount extends StatelessWidget {
  final void Function() onPressed;
  const NotHaveAccount({super.key,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don’t have an account?",
          style: getBoldStyle(color: ColorManager.gray, fontSize: 18,),
        ),
        CustomTextBtn(text: "Sign Up", onPressed: () {
          onPressed();
        }, fontSize: 18),
      ],
    );
  }
}
