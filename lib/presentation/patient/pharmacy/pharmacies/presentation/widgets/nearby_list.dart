import 'package:flutter/material.dart';

import '../../data/models/pharmacy_card_model.dart';
import 'pharmacy_card.dart';

class NearbyList extends StatelessWidget {
  const NearbyList({super.key});

  static const List<Map<String, dynamic>> _pharmacies = [
    {
      'id': '6a37a0277be05f1b2f2ae9de',
      'name': 'El-Eman Pharmacy',
      'location': 'Tala, Menofia',
      'distance': '350m',
      'deliveryTime': '15 min delivery',
      'medicinesCount': 180,
      'rating': 4.5,
      'reviewsCount': 92,
      'isOpen': true,
      'acceptsRx': false,
    },
    {
      'id': '6a37a0277be05f1b2f2ae9df',
      'name': 'Al-Shifaa Pharmacy',
      'location': 'Nasr City',
      'distance': '1.2 km',
      'deliveryTime': '30 min delivery',
      'medicinesCount': 320,
      'rating': 4.8,
      'reviewsCount': 248,
      'isOpen': true,
      'acceptsRx': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _pharmacies.length,
      separatorBuilder: (_, _) => const SizedBox(height: 16),
      itemBuilder: (_, index) {
        final pharmacy = _pharmacies[index];
        return PharmacyCard(
          pharmacy: PharmacyCardModel(
            id: pharmacy['id'] as String,
            name: pharmacy['name'] as String,
            location: pharmacy['location'] as String,
            distance: pharmacy['distance'] as String,
            deliveryTime: pharmacy['deliveryTime'] as String,
            medicinesCount: pharmacy['medicinesCount'] as int,
            rating: pharmacy['rating'] as double,
            reviewsCount: pharmacy['reviewsCount'] as int,
            isOpen: pharmacy['isOpen'] as bool,
            acceptsRx: pharmacy['acceptsRx'] as bool,
          ),
        );
      },
    );
  }
}
