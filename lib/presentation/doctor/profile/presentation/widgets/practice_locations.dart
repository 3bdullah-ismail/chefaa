import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/doctor_profile_entity.dart';
import 'location_card.dart';

class PracticeLocations extends StatelessWidget {
  final DoctorProfileEntity doctor;

  const PracticeLocations({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    final primaryLocation = doctor.location ?? 'Main Heart Center';
    final secondary = doctor.clinics != null && doctor.clinics! > 1;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          LocationCard(
            title: 'Main Heart Center',
            address: primaryLocation,
            statusLabel: 'Primary',
            isPrimary: true,
          ),
          if (secondary) ...[
            12.verticalSpace,
            const LocationCard(
              title: 'Additional Practice Location',
              address: 'Contact the clinic for the remaining branches.',
              statusLabel: 'Secondary',
              isPrimary: false,
              subdued: true,
            ),
          ],
        ],
      ),
    );
  }
}
