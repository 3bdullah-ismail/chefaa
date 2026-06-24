import 'package:flutter/material.dart';

import '../../../../../../core/resources/color_manager.dart';
import 'counter_button.dart';

class InteractivePurchaseCard extends StatelessWidget {
  final double unitPrice;
  final int quantity;
  final String currencySign;
  final void Function() onIncrement;
  final void Function() onDecrement;
  const InteractivePurchaseCard({
    super.key,
    required this.currencySign,
    required this.unitPrice,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff0F172A).withValues(alpha: 0.03),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(color: const Color(0xffF1F5F9)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "UNIT PRICE",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff94A3B8),
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    "${unitPrice.toStringAsFixed(2)} ",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Color(0xff0F172A),
                    ),
                  ),
                  Text(
                    currencySign,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: ColorManager.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: const Color(0xffF1F5F9),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                CounterButton(
                  icon: Icons.remove_rounded,
                  onPressed: quantity > 1 ? onDecrement : null,
                  isEnabled: quantity > 1,
                ),
                Container(
                  alignment: Alignment.center,
                  constraints: const BoxConstraints(minWidth: 44),
                  child: Text(
                    "$quantity",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Color(0xff0F172A),
                    ),
                  ),
                ),
                CounterButton(
                  icon: Icons.add_rounded,
                  onPressed: onIncrement,
                  isEnabled: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
