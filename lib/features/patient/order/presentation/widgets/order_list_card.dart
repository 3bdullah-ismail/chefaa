import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/features/patient/order/data/models/orders_list_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderListCard extends StatelessWidget {
  final OrderSummaryItem order;
  final VoidCallback onTrack;

  const OrderListCard({
    super.key,
    required this.order,
    required this.onTrack,
  });

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'delivered':
        return ColorManager.lightGreen;
      case 'cancelled':
      case 'canceled':
        return ColorManager.error;
      case 'preparing':
        return ColorManager.amber600;
      case 'on the way':
      case 'on_the_way':
        return ColorManager.blue600;
      case 'picked up':
      case 'picked_up':
      case 'rider_picked_up':
        return ColorManager.violet600;
      default:
        return ColorManager.primary;
    }
  }

  Color _statusBgColor(String status) {
    switch (status.toLowerCase()) {
      case 'delivered':
        return ColorManager.green100;
      case 'cancelled':
      case 'canceled':
        return ColorManager.lightRed;
      case 'preparing':
        return ColorManager.amber100;
      case 'on the way':
      case 'on_the_way':
        return ColorManager.blue100;
      case 'picked up':
      case 'picked_up':
      case 'rider_picked_up':
        return ColorManager.purple100;
      default:
        return ColorManager.lightBlue;
    }
  }

  IconData _statusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'delivered':
        return Icons.check_circle_rounded;
      case 'cancelled':
      case 'canceled':
        return Icons.cancel_rounded;
      case 'preparing':
        return Icons.medication_rounded;
      case 'on the way':
      case 'on_the_way':
        return Icons.directions_bike_rounded;
      case 'picked up':
      case 'picked_up':
      case 'rider_picked_up':
        return Icons.delivery_dining_rounded;
      default:
        return Icons.receipt_long_rounded;
    }
  }

  String _formatDate(String raw) {
    if (raw.isEmpty) return '';
    try {
      final dt = DateTime.parse(raw).toLocal();
      const months = [
        'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
      ];
      final hour = dt.hour > 12 ? dt.hour - 12 : (dt.hour == 0 ? 12 : dt.hour);
      final amPm = dt.hour >= 12 ? 'PM' : 'AM';
      final min = dt.minute.toString().padLeft(2, '0');
      return '${dt.day} ${months[dt.month - 1]} ${dt.year}  •  $hour:$min $amPm';
    } catch (_) {
      return raw;
    }
  }

  bool _isActive(String status) {
    final s = status.toLowerCase();
    return s != 'delivered' && s != 'cancelled' && s != 'canceled';
  }

  @override
  Widget build(BuildContext context) {
    final color = _statusColor(order.status);
    final bgColor = _statusBgColor(order.status);
    final icon = _statusIcon(order.status);
    final active = _isActive(order.status);

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withAlpha(18),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(20.r),
          onTap: onTrack,
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header row
                Row(
                  children: [
                    // Status icon circle
                    Container(
                      width: 48.w,
                      height: 48.w,
                      decoration: BoxDecoration(
                        color: bgColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(icon, color: color, size: 24.sp),
                    ),
                    12.horizontalSpace,
                    // Order info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Order #${order.orderNumber}',
                            style: getBoldStyle(
                              color: ColorManager.black,
                              fontSize: 15.sp,
                            ),
                          ),
                          4.verticalSpace,
                          if (order.pharmacyName.isNotEmpty)
                            Text(
                              order.pharmacyName,
                              style: getRegularStyle(
                                color: ColorManager.gray,
                                fontSize: 12.sp,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                        ],
                      ),
                    ),
                    // Status badge
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 5.h,
                      ),
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        order.status,
                        style: getSemiBoldStyle(
                          color: color,
                          fontSize: 11.sp,
                        ),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: Divider(
                    color: ColorManager.input.withValues(alpha: 0.6),
                    thickness: 0.8,
                  ),
                ),

                // Details row
                Row(
                  children: [
                    _InfoChip(
                      icon: Icons.shopping_bag_outlined,
                      label:
                          '${order.itemsCount} ${order.itemsCount == 1 ? 'item' : 'items'}',
                    ),
                    12.horizontalSpace,
                    _InfoChip(
                      icon: Icons.payments_outlined,
                      label: 'EGP ${order.totalPrice.toStringAsFixed(2)}',
                    ),
                    12.horizontalSpace,
                    _InfoChip(
                      icon: Icons.credit_card_rounded,
                      label: order.paymentMethod,
                    ),
                  ],
                ),

                if (order.createdAt.isNotEmpty) ...[
                  8.verticalSpace,
                  Row(
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        size: 13.sp,
                        color: ColorManager.gray,
                      ),
                      4.horizontalSpace,
                      Text(
                        _formatDate(order.createdAt),
                        style: getRegularStyle(
                          color: ColorManager.gray,
                          fontSize: 11.sp,
                        ),
                      ),
                    ],
                  ),
                ],

                if (active) ...[
                  14.verticalSpace,
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: onTrack,
                      icon: Icon(
                        Icons.my_location_rounded,
                        size: 16.sp,
                        color: ColorManager.white,
                      ),
                      label: Text(
                        'Track Order',
                        style: getSemiBoldStyle(
                          color: ColorManager.white,
                          fontSize: 13.sp,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.primary,
                        foregroundColor: ColorManager.white,
                        elevation: 0,
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13.sp, color: ColorManager.primary),
        4.horizontalSpace,
        Text(
          label,
          style: getMediumStyle(
            color: ColorManager.darkGray,
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }
}
