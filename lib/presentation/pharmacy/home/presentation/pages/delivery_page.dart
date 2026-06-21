import 'package:chefaa/presentation/pharmacy/home/presentation/widgets/deliver_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/resources/color_manager.dart';
import '../widgets/section_title.dart';
import '../widgets/staff_summary_card.dart';

class DeliveryTab extends StatelessWidget {
  final int staffAvailable;
  final int staffBusy;
  final int staffTotal;

  const DeliveryTab({
    super.key,
    required this.staffAvailable,
    required this.staffBusy,
    required this.staffTotal,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16.r),
      children: [
        const SectionTitle(title: 'Delivery Staff'),
        SizedBox(height: 10.h),
        StaffSummaryCard(
          available: staffAvailable,
          busy: staffBusy,
          total: staffTotal,
        ),
        SizedBox(height: 20.h),
        DriverGroupCard(
          label: 'Available Now',
          statusColor: ColorManager.lightGreen,
          drivers: [
            {
              "name": "Amer Ahmed",
              "phone": "01502888622",
              "vehicleLabel": "Electric Scooter",
              "isAvailable": true,
              "activeOrders": 0,
            },
            {
              "name": "Maged Mohamed",
              "phone": "01502888637",
              "vehicleLabel": "Car",
              "isAvailable": true,
              "activeOrders": 0,
            },
          ],
        ),
        30.verticalSpace,
        DriverGroupCard(
          label: 'Currently Busy',
          statusColor: ColorManager.error,
          drivers: const [
            {
              "name": "Omar Shaban",
              "phone": "01018275619",
              "vehicleLabel": "Electric Scooter",
              "isAvailable": false,
              "activeOrders": 2,
            },
            {
              "name": "Ahmed Emad",
              "phone": "01000000001",
              "vehicleLabel": "Motorcycle",
              "isAvailable": false,
              "activeOrders": 1,
            },
          ],
        ),

      ],
    );
  }
}
