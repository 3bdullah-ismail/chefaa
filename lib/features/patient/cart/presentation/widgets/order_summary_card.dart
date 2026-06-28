import 'package:chefaa/features/patient/cart/presentation/widgets/summary_row_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';

class OrderSummaryCard extends StatelessWidget {
  final double subtotal;

  final double deliveryFee;

  final double total;
  final void Function() onPressed;
  final String btnTitle;

  const OrderSummaryCard({
    super.key,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
    required this.onPressed,
    required this.btnTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),

      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(18),

            decoration: BoxDecoration(
              color: ColorManager.lightGray,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(80),
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),

            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Order Summary",
                    style: getBoldStyle(
                      color: ColorManager.black,
                      fontSize: 20.sp,
                    ),
                  ),
                ),
                20.verticalSpace,

                SummaryRowCard(
                  title: "Subtotal",
                  value: "EGP ${subtotal.toStringAsFixed(2)}",
                ),

                const SizedBox(height: 14),

                SummaryRowCard(
                  title: "Delivery Fee",
                  value: "EGP ${deliveryFee.toStringAsFixed(2)}",
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 18),
                  child: Divider(height: 1),
                ),

                SummaryRowCard(
                  title: "Total",
                  value: "EGP ${total.toStringAsFixed(2)}",
                  isTotal: true,
                ),
              ],
            ),
          ),
          20.verticalSpace,

          SizedBox(
            width: double.infinity,
            height: 58.h,

            child: ElevatedButton(
              onPressed: () {
                onPressed();
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff0B73B7),

                elevation: 0,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),

              child: Text(
                btnTitle,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
