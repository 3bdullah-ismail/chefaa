import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/presentation/patient/order/presentation/widgets/time_line_steps_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/resources/color_manager.dart';

class OrderTimelineStepper extends StatelessWidget {
  const OrderTimelineStepper({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withAlpha(80),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Order Progress",
            style: getBoldStyle(color: ColorManager.black, fontSize: 18.sp),
          ),
          const SizedBox(height: 24),

          const TimeLineStepsCard(
            defaultIcon: Icons.receipt_long_rounded,
            title: "Order Confirmed",
            subtitle: "Your order was received and processed",
            time: "9:30 AM",
            isCompleted: true,
          ),

          const TimeLineStepsCard(
            defaultIcon: Icons.healing_rounded,
            title: "Pharmacy Preparing Order",
            subtitle: "Al-Shifa Pharmacy started packing your medicines",
            time: "9:33 AM",
            isCompleted: true,
          ),

          const TimeLineStepsCard(
            defaultIcon: Icons.inventory_2_rounded,
            title: "Rider Picked Up Order",
            subtitle: "Mohamed collected your order from the pharmacy",
            time: "9:48 AM",
            isCompleted: true,
          ),

          const TimeLineStepsCard(
            defaultIcon: Icons.directions_bike_rounded,
            title: "On the Way",
            subtitle: "Rider is ~2.5 km from your location",
            time: "10:16 AM",
            isActive: true,
            isLast: true,
          ),
        ],
      ),
    );
  }
}
