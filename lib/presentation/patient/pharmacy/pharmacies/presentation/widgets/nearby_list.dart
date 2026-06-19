import 'package:flutter/material.dart';

import 'pharmacy_card.dart';

class NearbyList extends StatelessWidget {
  const NearbyList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 2,
      separatorBuilder: (_, _) => const SizedBox(height: 16),
      itemBuilder: (_, _) {
        return const PharmacyCard(
          name: 'El-Eman Pharmacy',
          location: 'Tala, Menofia',
          distance: '350m',
          deliveryTime: '15 min delivery',
          medicinesCount: 180,
          rating: 4.5,
          reviewsCount: 92,
          isOpen: true,
          acceptsRx: false,
        );
      },
    );
  }
}