import 'package:chefaa/core/resources/assets_manager.dart';
import 'package:chefaa/presentation/patient/pharmacy/pharmacies/presentation/widgets/map_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/resources/color_manager.dart';
import '../../../../../../core/widget/inside_app_bar.dart';
import '../widgets/action_button_card.dart';
import '../widgets/horizontal_info_badge.dart';
import '../widgets/pharmacy_header_card.dart';
import '../widgets/premium_card_decoration.dart';
import '../widgets/section_title.dart';
import '../widgets/service_row.dart';

import '../../../medicines/presentation/pages/pharmacy_medicines_page.dart';

class PharmacyDetailsPage extends StatelessWidget {
  final String name;
  final String location;
  final String distance;
  final String deliveryTime;
  final int medicinesCount;
  final double rating;
  final int reviewsCount;
  final bool isOpen;
  final bool acceptsRx;

  final double lat;
  final double lng;

  const PharmacyDetailsPage({
    super.key,
    required this.name,
    required this.location,
    required this.distance,
    required this.deliveryTime,
    required this.medicinesCount,
    required this.rating,
    required this.reviewsCount,
    required this.isOpen,
    required this.acceptsRx,
    required this.lat,
    required this.lng,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),

      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: InsideAppBar(
          title: "Pharmacy Details",
          subtitle:
              "Explore the pharmacy's services,performance, and location details",
        ),
      ),

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PharmacyHeaderCard(
              name: name,
              location: location,
              distance: distance,
              isOpen: isOpen,
              acceptsRx: acceptsRx,
            ),

            16.verticalSpace,

            ActionButtonCard(
              icon: SvgAssets.phone,
              label: "Call Pharmacy",
              onTap: () {},
            ),

            12.verticalSpace,

            ActionButtonCard(
              icon: SvgAssets.orderPharmacy,
              label: "View Medicines",
              color: ColorManager.primary,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PharmacyMedicinesPage(pharmacyName: name),
                  ),
                );
              },
            ),

            24.verticalSpace,

            const SectionTitle(title: "Performance & Capacity"),

            12.verticalSpace,

            SizedBox(
              height: 80.h,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  const HorizontalInfoBadge(
                    icon: Icons.schedule_rounded,
                    title: "Opening Hours",
                    value: "24/7 Service",
                    color: ColorManager.lightGreen,
                  ),
                  HorizontalInfoBadge(
                    icon: Icons.speed_rounded,
                    title: "Avg Delivery",
                    value: deliveryTime,
                    color: ColorManager.primary,
                  ),
                  HorizontalInfoBadge(
                    icon: Icons.medication_rounded,
                    title: "Stock Database",
                    value: "$medicinesCount Products",
                    color: ColorManager.darkGray,
                  ),
                  HorizontalInfoBadge(
                    icon: Icons.star_rounded,
                    title: "Trust Score",
                    value: "$rating ($reviewsCount reviews)",
                    color: ColorManager.gold,
                  ),
                ],
              ),
            ),

            24.verticalSpace,

            const SectionTitle(title: "Available Services"),

            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: premiumCardDecoration(),
              child: const Column(
                children: [
                  ServiceRow(
                    icon: Icons.local_shipping_rounded,
                    title: "Express Home Delivery",
                    description:
                        "Get your prescription delivered safely to your door step.",
                    color: ColorManager.primary,
                  ),
                  Divider(height: 24),
                  ServiceRow(
                    icon: Icons.biotech_rounded,
                    title: "Prescription Preparation",
                    description:
                        "Submit your Rx files and retrieve compound formula medicines.",
                    color: ColorManager.lightGreen,
                  ),
                  Divider(height: 24),
                  ServiceRow(
                    icon: Icons.health_and_safety_rounded,
                    title: "Medical Insurance Support",
                    description:
                        "Covers multi-national governmental & corporate health cards.",
                    color: ColorManager.gold,
                  ),
                ],
              ),
            ),

            24.verticalSpace,

            InteractiveMapCard(lat: lat, lng: lng, location: location),
          ],
        ),
      ),
    );
  }
}
