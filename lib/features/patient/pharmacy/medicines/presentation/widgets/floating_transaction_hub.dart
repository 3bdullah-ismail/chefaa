import 'package:flutter/material.dart';

import 'package:chefaa/core/resources/color_manager.dart';

class FloatingTransactionHub extends StatelessWidget {
  final double totalPrice;
  final String currencySign;
  final int quantity;
  final VoidCallback onAddToCart;

  const FloatingTransactionHub({
    super.key,
    required this.totalPrice,
    required this.currencySign,
    required this.quantity,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        24,
        16,
        24,
        MediaQuery.of(context).padding.bottom + 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xff0F172A).withValues(alpha: 0.06),
            blurRadius: 24,
            offset: const Offset(0, -6),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
      ),
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "TOTAL PRICE",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff94A3B8),
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                "${totalPrice.toStringAsFixed(2)} $currencySign",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: ColorManager.primary,
                ),
              ),
            ],
          ),

          const SizedBox(width: 24),

          Expanded(
            child: SizedBox(
              height: 52,
              child: ElevatedButton(
                onPressed: onAddToCart,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.add_shopping_cart_rounded, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      "Add $quantity to Cart",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
