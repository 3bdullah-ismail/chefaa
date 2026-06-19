
import 'package:chefaa/presentation/patient/cart/presentation/widgets/order_summary_card.dart';
import 'package:chefaa/presentation/patient/order/presentation/pages/track_order_page.dart';
import 'package:chefaa/presentation/patient/payment/presentation/widgets/card_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widget/inside_app_bar.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final cardNumber = TextEditingController();
  final holder = TextEditingController();
  final expiry = TextEditingController();
  final cvv = TextEditingController();

  double subtotal = 37.5;
  double delivery = 15.0;

  double get total => subtotal + delivery;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: InsideAppBar(
          title: "Payment",
          subtitle: "Enter your card details to complete the payment",
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CardDetails(
              cardNumber: cardNumber,
              holder: holder,
              expiry: expiry,
              cvv: cvv,
            ),
            16.verticalSpace,
            OrderSummaryCard(
              subtotal: subtotal,
              deliveryFee: delivery,
              total: total,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const TrackOrderPage()),
                );
              },
              btnTitle: "Payment Now",
            ),

          ],
        ),
      ),
    );
  }


}
