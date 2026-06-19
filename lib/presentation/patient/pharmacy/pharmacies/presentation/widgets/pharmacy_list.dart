import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'pharmacy_card.dart';

class PharmacyList extends StatelessWidget {
  const PharmacyList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      separatorBuilder: (_, _) => 16.verticalSpace,
      itemBuilder: (_, _) {
        return const PharmacyCard(
          name: 'Al-Shifaa Pharmacy',
          location: 'Nasr City',
          distance: '1.2 km',
          deliveryTime: '30 min delivery',
          medicinesCount: 320,
          rating: 4.8,
          reviewsCount: 248,
          isOpen: true,
          acceptsRx: true,
        );
      },
    );
  }
}