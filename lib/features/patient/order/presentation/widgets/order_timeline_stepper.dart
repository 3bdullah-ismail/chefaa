import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/features/patient/order/data/models/track_order_response.dart';
import 'package:chefaa/features/patient/order/presentation/widgets/time_line_steps_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chefaa/core/resources/color_manager.dart';

class OrderTimelineStepper extends StatelessWidget {
  final StatusTimeline timeline;

  const OrderTimelineStepper({
    super.key,
    required this.timeline,
  });

  @override
  Widget build(BuildContext context) {
    final confirmed = timeline.orderConfirmed;
    final preparing = timeline.pharmacyPreparing;
    final pickedUp = timeline.riderPickedUp;
    final onWay = timeline.onTheWay;

    final bool isConfirmedCompleted = confirmed?.isCompleted ?? false;
    final bool isPreparingCompleted = preparing?.isCompleted ?? false;
    final bool isPickedUpCompleted = pickedUp?.isCompleted ?? false;
    final bool isOnWayCompleted = onWay?.isCompleted ?? false;

    final bool isConfirmedActive = !isConfirmedCompleted;
    final bool isPreparingActive = isConfirmedCompleted && !isPreparingCompleted;
    final bool isPickedUpActive = isPreparingCompleted && !isPickedUpCompleted;
    final bool isOnWayActive = isPickedUpCompleted && !isOnWayCompleted;

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
          if (confirmed != null)
            TimeLineStepsCard(
              defaultIcon: Icons.receipt_long_rounded,
              title: confirmed.title,
              subtitle: confirmed.description,
              time: confirmed.time ?? "",
              isCompleted: isConfirmedCompleted,
              isActive: isConfirmedActive,
            ),
          if (preparing != null)
            TimeLineStepsCard(
              defaultIcon: Icons.healing_rounded,
              title: preparing.title,
              subtitle: preparing.description,
              time: preparing.time ?? "",
              isCompleted: isPreparingCompleted,
              isActive: isPreparingActive,
            ),
          if (pickedUp != null)
            TimeLineStepsCard(
              defaultIcon: Icons.inventory_2_rounded,
              title: pickedUp.title,
              subtitle: pickedUp.description,
              time: pickedUp.time ?? "",
              isCompleted: isPickedUpCompleted,
              isActive: isPickedUpActive,
            ),
          if (onWay != null)
            TimeLineStepsCard(
              defaultIcon: Icons.directions_bike_rounded,
              title: onWay.title,
              subtitle: onWay.description,
              time: onWay.time ?? "",
              isCompleted: isOnWayCompleted,
              isActive: isOnWayActive,
              isLast: true,
            ),
        ],
      ),
    );
  }
}
