import 'package:flutter/material.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/widget/custom_circle_avatar.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage({super.key, required this.message, required this.isUser});

  final String message;
  final bool isUser;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: isUser
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          if (!isUser) ...[
            const CustomCircleAvatar(imagePath: 'assets/images/bot.png'),
            const SizedBox(width: 8),
          ],
          if (isUser) const SizedBox(width: 40),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isUser ? ColorManager.primary : ColorManager.lightBlue,
                borderRadius: BorderRadius.only(
                  topLeft: isUser ? const Radius.circular(12) : Radius.zero,
                  topRight: isUser ? Radius.zero : const Radius.circular(12),
                  bottomLeft: const Radius.circular(12),
                  bottomRight: const Radius.circular(12),
                ),
              ),
              child: Text(
                message,
                style: TextStyle(
                  color: isUser ? ColorManager.white : ColorManager.black,
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
            ),
          ),
          if (!isUser) const SizedBox(width: 40),
        ],
      ),
    );
  }
}
