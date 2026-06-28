import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:chefaa/core/resources/values_manager.dart';

class ChatMessageBubble extends StatelessWidget {
  final String message;
  final bool isBot;

  const ChatMessageBubble({
    super.key,
    required this.message,
    required this.isBot,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isBot ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p16,
          vertical: AppPadding.p12,
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * .75,
        ),
        decoration: BoxDecoration(
          color: isBot ? ColorManager.lightGray : ColorManager.primary,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: Radius.circular(isBot ? 0 : 25.r),
            bottomRight: Radius.circular(isBot ? 25.r : 0),
          ),
          boxShadow: [
            BoxShadow(
              color: ColorManager.black.withAlpha(80),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Text(
          message,
          style: getMediumStyle(
            color: isBot ? ColorManager.black : ColorManager.white,
            fontSize: 15.sp,
          ),
        ),
      ),
    );
  }
}
