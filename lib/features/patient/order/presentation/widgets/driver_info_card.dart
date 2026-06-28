import 'package:chefaa/features/patient/order/data/models/track_order_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:chefaa/core/resources/color_manager.dart';
import 'circle_button.dart';

class DriverInfoCard extends StatelessWidget {
  final RiderInfo rider;

  const DriverInfoCard({
    super.key,
    required this.rider,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(25.r),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withAlpha(80),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: const BoxDecoration(
              color: ColorManager.lightBlue,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person_rounded,
              color: ColorManager.primary,
              size: 28,
            ),
          ),
          15.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  rider.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: ColorManager.black,
                    fontSize: 16,
                  ),
                ),
                7.horizontalSpace,
                Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      color: ColorManager.gold,
                      size: 20,
                    ),
                    7.horizontalSpace,
                    Text(
                      rider.rating.toString(),
                      style: const TextStyle(
                        color: ColorManager.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    7.horizontalSpace,
                    const Text(
                      "• Delivery Agent",
                      style: TextStyle(color: ColorManager.gray, fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              CircleButton(
                icon: Icons.call_rounded,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Phone: ${rider.phoneNumber}'),
                    ),
                  );
                },
                color: ColorManager.lightGreen,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
