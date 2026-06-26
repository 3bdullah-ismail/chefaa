import 'package:chefaa/core/resources/values_manager.dart';
import 'package:chefaa/core/routes/app_routes_names.dart';
import 'package:chefaa/core/widget/inside_app_bar.dart';
import 'package:chefaa/presentation/doctor/layout/home/presentation/widgets/custom_outline_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/cart_item_card.dart';
import '../widgets/order_summary_card.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final List<Map<String, dynamic>> cartItems = [
    {"name": "Panadol Extra", "dosage": "500mg", "price": 12.5, "quantity": 1},
    {"name": "Vitamin C", "dosage": "250mg", "price": 18.0, "quantity": 2},
    {"name": "Vitamin E", "dosage": "250mg", "price": 25.0, "quantity": 2},
  ];

  double deliveryFee = 15;

  double get subtotal {
    double total = 0;

    for (var item in cartItems) {
      total += item["price"] * item["quantity"];
    }

    return total;
  }

  double get total => subtotal + deliveryFee;

  void increaseQuantity(int index) {
    setState(() {
      cartItems[index]["quantity"]++;
    });
  }

  void decreaseQuantity(int index) {
    setState(() {
      if (cartItems[index]["quantity"] > 1) {
        cartItems[index]["quantity"]--;
      }
    });
  }

  void removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: InsideAppBar(
          title: " My Cart ",
          subtitle: "Check your items before placing order",
          isLayout: true,
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p20,
          vertical: AppPadding.p32,
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: cartItems.length,
                shrinkWrap: true,
                separatorBuilder: (_, _) => 16.verticalSpace,

                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return CartItemCard(
                    item: item,
                    index: index,
                    onIncrease: () => increaseQuantity(index),
                    onDecrease: () => decreaseQuantity(index),
                    onDelete: () => removeItem(index),
                  );
                },
              ),
            ),

            20.verticalSpace,
            CustomOutlineButton(text: "Add More Items", onPressed: () {}),

            10.verticalSpace,
            OrderSummaryCard(
              subtotal: subtotal,
              deliveryFee: deliveryFee,
              total: total,
              onPressed: () {
                Navigator.pushNamed(context, AppRoutesNames.checkoutPage);
              },
              btnTitle: "Proceed to Checkout",
            ),
          ],
        ),
      ),
    );
  }
}
