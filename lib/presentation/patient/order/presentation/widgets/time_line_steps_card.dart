import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/color_manager.dart';

class TimeLineStepsCard extends StatelessWidget {
  final IconData defaultIcon;
  final String title;
  final String subtitle;
  final String time;
  final bool isLast;
  final bool isCompleted;

  final bool isActive;

  const TimeLineStepsCard({
    super.key,
    required this.defaultIcon,
    required this.title,
    required this.subtitle,
    required this.time,
    this.isLast = false,
    this.isCompleted = false,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    IconData finalIcon = isCompleted ? Icons.check_circle_rounded : defaultIcon;

    Color itemColor = isCompleted
        ? ColorManager.lightGreen
        : isActive
        ? ColorManager.primary
        : ColorManager.gray.withAlpha(100);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: isActive
                    ? ColorManager.primary
                    : itemColor.withAlpha(20),
                shape: BoxShape.circle,
                border: isActive
                    ? Border.all(color: ColorManager.white, width: 2)
                    : null,
                boxShadow: isActive
                    ? [
                        BoxShadow(
                          color: ColorManager.primary.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ]
                    : [],
              ),
              child: Icon(
                finalIcon,
                size: isCompleted ? 25 : 22,
                color: isActive ? ColorManager.white : itemColor,
              ),
            ),
            if (!isLast)
              Container(
                width: 4,
                height: 50,
                color: isCompleted
                    ? ColorManager.lightGreen
                    : ColorManager.input.withValues(alpha: 0.7),
              ),
          ],
        ),
        const SizedBox(width: 14),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: isActive || isCompleted
                          ? FontWeight.bold
                          : FontWeight.w500,
                      color: isActive
                          ? ColorManager.primary
                          : ColorManager.black,
                    ),
                  ),
                  if (isActive) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: ColorManager.primary.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        "Now ",
                        style: TextStyle(
                          color: ColorManager.primary,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 13,
                  color: isActive ? ColorManager.darkGray : ColorManager.gray,
                  fontWeight: isActive ? FontWeight.w500 : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),

        Padding(
          padding: const EdgeInsets.only(top: 6.0),
          child: Text(
            isActive ? "Exp $time" : time,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
              color: isActive ? ColorManager.primary : ColorManager.gray,
            ),
          ),
        ),
      ],
    );
  }
}
