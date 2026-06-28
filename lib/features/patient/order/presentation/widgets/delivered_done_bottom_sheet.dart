import 'package:flutter/material.dart';

import 'package:chefaa/core/resources/color_manager.dart';

class DeliveredDoneBottomSheet extends StatelessWidget {
  const DeliveredDoneBottomSheet({super.key});

  Widget buildItem(String name, int quantity) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle_rounded,
            color: ColorManager.lightGreen,
            size: 22,
          ),
          const SizedBox(width: 14),

          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: ColorManager.black,
              ),
            ),
          ),

          Text(
            "${quantity}x",
            style: const TextStyle(
              fontSize: 13,
              color: ColorManager.darkGray,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 5,
            decoration: BoxDecoration(
              color: ColorManager.input.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          const SizedBox(height: 24),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: ColorManager.lightGreen.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.gpp_good_rounded,
              color: ColorManager.lightGreen,
              size: 45,
            ),
          ),

          const SizedBox(height: 16),

          const Text(
            "Order Delivered!",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: ColorManager.black,
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            "All items have been successfully handed over.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: ColorManager.gray,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 24),

          Container(
            height: 1,
            color: ColorManager.input.withValues(alpha: 0.5),
          ),

          const SizedBox(height: 12),

          buildItem("Paracetamol 500mg", 2),
          buildItem("Amoxicillin 500mg", 1),
          buildItem("Metformin 500mg", 1),

          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.primary,
                foregroundColor: ColorManager.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text(
                "Back to Home",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
