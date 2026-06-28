import 'package:flutter/material.dart';

import 'package:chefaa/core/resources/color_manager.dart';

class IdentityMedicineCard extends StatelessWidget {
  final String name;
  final String activeIngredient;
  const IdentityMedicineCard({
    super.key,
    required this.name,
    required this.activeIngredient,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: ColorManager.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            "VERIFIED CLINICAL MONOGRAPH",
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w800,
              color: ColorManager.primary,
              letterSpacing: 0.8,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          name,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w900,
            color: Color(0xff0F172A),
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          "Molecule: $activeIngredient",
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xff64748B),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
