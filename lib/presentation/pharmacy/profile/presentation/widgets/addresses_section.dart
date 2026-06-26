import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/font_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';

class AddressesSection extends StatelessWidget {
  final List<dynamic> addresses;

  const AddressesSection({super.key, required this.addresses});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.location_on_rounded,
                  color: Colors.red.shade400,
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                "Addresses & Locations",
                style: getBoldStyle(
                  color: Colors.black87,
                  fontSize: FontSize.s16.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: addresses.length,
            separatorBuilder: (context, index) => SizedBox(height: 12.h),
            itemBuilder: (context, index) {
              final item = addresses[index];
              final String addressText =
                  (item is Map ? item["addressText"] : null)?.toString() ?? "";

              List<double> coords = [];
              if (item is Map && item["location"] is Map) {
                final loc = item["location"];
                if (loc["coordinates"] is List) {
                  coords = (loc["coordinates"] as List)
                      .map((e) => double.tryParse(e.toString()) ?? 0.0)
                      .toList();
                }
              }

              return Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.grey.shade100),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.map_rounded,
                      color: Colors.grey.shade400,
                      size: 20.sp,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            addressText,
                            style: getMediumStyle(
                              color: Colors.black87,
                              fontSize: FontSize.s14.sp,
                            ),
                          ),
                          if (coords.length >= 2) ...[
                            SizedBox(height: 6.h),
                            Row(
                              children: [
                                Icon(
                                  Icons.gps_fixed_rounded,
                                  size: 14.sp,
                                  color: ColorManager.primary.withValues(alpha: 0.6),
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  "${coords[1].toStringAsFixed(4)}, ${coords[0].toStringAsFixed(4)}",
                                  style: getRegularStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: FontSize.s12.sp,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
