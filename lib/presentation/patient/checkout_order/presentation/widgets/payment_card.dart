import 'package:chefaa/presentation/patient/checkout_order/presentation/widgets/payment_title_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentCard extends StatelessWidget {
  final String paymentMethod;
  final VoidCallback cashOnTap;
  final VoidCallback onlineOnTap;

  const PaymentCard({
    super.key,
    required this.paymentMethod,
    required this.cashOnTap,
    required this.onlineOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PaymentTitleCard(
          title: "Cash on Delivery",
          value: "cod",
          subtitle: "Pay with cash upon delivery",
          selected: paymentMethod == "cod",
          onTap: cashOnTap,
        ),

        10.verticalSpace,

        PaymentTitleCard(
          title: "Online Payment",
          value: "online",
          subtitle: "Pay securely using your credit or debit card",
          selected: paymentMethod == "online",
          onTap: onlineOnTap,
        ),
      ],
    );
  }
}