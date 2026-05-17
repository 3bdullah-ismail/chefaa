import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/color_manager.dart';

class ChatInputBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const ChatInputBar({
    super.key,
    required this.controller,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.attach_file, color: ColorManager.gray),
            onPressed: () {},
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: TextField(
              controller: controller,
              onSubmitted: (_) => onSend(),
              decoration: const InputDecoration(
                hintText: 'Ask Chefaa Assistant...',
                hintStyle: TextStyle(color: ColorManager.gray, fontSize: 14),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 4),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Container(
            decoration: const BoxDecoration(
              color: ColorManager.primary,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.send, color: ColorManager.white),
              onPressed: onSend,
            ),
          ),
        ],
      ),
    );
  }
}
