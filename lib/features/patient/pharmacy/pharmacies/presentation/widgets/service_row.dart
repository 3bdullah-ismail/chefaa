import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:chefaa/core/resources/color_manager.dart';

class ServiceRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  const ServiceRow({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 20.r,
          backgroundColor: color.withAlpha(30),
          child: Icon(icon, color: color, size: 18),
        ),

        15.horizontalSpace,

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: ColorManager.black,
                ),
              ),

              const SizedBox(height: 3),

              Text(
                description,
                style: const TextStyle(
                  fontSize: 12,
                  color: ColorManager.gray,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
