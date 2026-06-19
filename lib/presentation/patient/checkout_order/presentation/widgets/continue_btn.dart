import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../order/presentation/pages/track_order_page.dart';
import '../../../payment/presentation/pages/payment_page.dart';

class ContinueBtn extends StatelessWidget {
  final String paymentMethod;

  const ContinueBtn({super.key, required this.paymentMethod});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorManager.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
          elevation: 4,
        ),
        onPressed: () {
          if (paymentMethod == "online") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PaymentPage()),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const TrackOrderPage()),
            );
          }
        },
        child: Text(
          "Continue",
          style: getBoldStyle(color: ColorManager.white, fontSize: 18.sp),
        ),
      ),
    );
  }
}
