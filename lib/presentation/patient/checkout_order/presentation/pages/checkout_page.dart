
import 'package:chefaa/core/resources/values_manager.dart';
import 'package:chefaa/presentation/patient/checkout_order/presentation/widgets/checkout_summary_card.dart';
import 'package:chefaa/presentation/patient/checkout_order/presentation/widgets/delivery_card.dart';
import 'package:chefaa/presentation/patient/checkout_order/presentation/widgets/delivery_form.dart';
import 'package:chefaa/presentation/patient/checkout_order/presentation/widgets/payment_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widget/inside_app_bar.dart';
import '../widgets/continue_btn.dart';
import '../widgets/custom_card.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String paymentMethod = "cod";

  double subtotal = 37.5;
  double delivery = 15.0;

  double get total => subtotal + delivery;

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final cityController = TextEditingController();
  final streetController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: InsideAppBar(
          title: "Checkout",
          subtitle: "Enter your delivery and payment information",
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppPadding.p20),
        child: Column(
          children: [
            20.verticalSpace,
            const CustomCard(title: "Delivery Method", child: DeliveryCard()),
            15.verticalSpace,
            CustomCard(
              title: "Delivery Information",
              child: DeliveryForm(
                nameController: nameController,
                phoneController: phoneController,
                cityController: cityController,
                streetController: streetController,
              ),
            ),
            15.verticalSpace,

            CustomCard(
              title: "Payment Method",
              child: PaymentCard(
                paymentMethod: paymentMethod,
                cashOnTap: () {
                  setState(() {
                    paymentMethod = "cod";
                  });
                },
                onlineOnTap: () {
                  setState(() {
                    paymentMethod = "online";
                  });
                },
              ),
            ),
            15.verticalSpace,

            CheckoutSummaryCard(
              subtotal: subtotal,
              delivery: delivery,
              total: total,
            ),
            25.verticalSpace,
            ContinueBtn(paymentMethod: paymentMethod),
          ],
        ),
      ),
    );
  }
}
