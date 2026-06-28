import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:chefaa/features/patient/pharmacy/pharmacies/data/models/pharmacy_card_model.dart';
import 'package:chefaa/features/patient/pharmacy/pharmacies/presentation/manager/pharmacy_search_cubit.dart';
import 'pharmacy_card.dart';

class PharmacyList extends StatelessWidget {
  const PharmacyList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PharmacySearchCubit, PharmacySearchState>(
      builder: (context, state) {
        if (state is PharmacySearchLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is PharmacySearchFailure) {
          return Center(child: Text(state.message));
        }

        if (state is PharmacySearchSuccess) {
          final pharmacies = state.response.data ?? [];
          
          if (pharmacies.isEmpty) {
            return const Center(child: Text('No pharmacies found'));
          }

          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: pharmacies.length,
            separatorBuilder: (_, _) => 16.verticalSpace,
            itemBuilder: (_, index) {
              final pharmacy = pharmacies[index];
              return PharmacyCard(
                pharmacy: PharmacyCardModel(
                  id: pharmacy.id ?? '',
                  name: pharmacy.pharmacyName ?? 'Unknown',
                  location: pharmacy.addresses != null && pharmacy.addresses!.isNotEmpty
                      ? pharmacy.addresses!.first.addressText ?? 'Unknown'
                      : 'Unknown',
                  distance: '${pharmacy.distanceKm ?? 0} km',
                  deliveryTime: pharmacy.deliveryTime ?? '',
                  medicinesCount: pharmacy.availableMedicinesCount ?? 0,
                  rating: (pharmacy.rating ?? 0).toDouble(),
                  reviewsCount: 0, // API doesn't return this
                  isOpen: true, // Assuming true since search results don't indicate openNow
                  acceptsRx: true, // Assuming true
                ),
              );
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
