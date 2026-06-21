import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/color_manager.dart';

class MedicineTile extends StatelessWidget {
  final String name;
  final String category;
  final int stock;
  final int totalStock;
  final int price;
  final String status;
  final Color statusColor;

  const MedicineTile({
    super.key,
    required this.name,
    required this.category,
    required this.stock,
    required this.price,
    required this.status,
    required this.statusColor,
    required this.totalStock,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ColorManager.input.withAlpha(150),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: getBoldStyle(color: Colors.black, fontSize: 16.sp),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            category,
            style: TextStyle(color: Colors.grey[600], fontSize: 13),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:const  EdgeInsets.symmetric(horizontal: AppPadding.p8, vertical: AppPadding.p2),
                decoration: BoxDecoration(
                  color: ColorManager.primary.withAlpha(50),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Stock: $stock / $totalStock",
                  style: getMediumStyle(
                    color: ColorManager.primary,
                    fontSize: 14.sp,
                  ),
                ),
              ),
              Text(
                "Price: $price EGP",
                style: getBoldStyle(color: ColorManager.black, fontSize: 14.sp),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
