import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/color_manager.dart';

class OrderList extends StatelessWidget {
  final List<Map<String, String>> orders;

  const OrderList({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return const Center(
        child: Text("No Orders Found", style: TextStyle(color: Colors.grey)),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        final isNew = order["status"] == "New";

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Order #${order["id"]}",
                    style: getBoldStyle(color: ColorManager.error, fontSize: 14.sp)
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: isNew
                          ? Colors.orange.shade100
                          : Colors.green.shade100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      order["status"]!,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isNew ? Colors.orange : Colors.green,
                      ),
                    ),
                  ),
                ],
              ),

            10.verticalSpace,

              Row(
                children: [
                  Expanded(
                    child: Text(
                      order["name"]!,
                      style: getBoldStyle(color: ColorManager.black, fontSize: 14.sp)
                    ),
                  ),
                  10.horizontalSpace,
                  Text(
                      order["items"]!,
                      style: getMediumStyle(color: ColorManager.gray, fontSize: 14.sp)
                  ),
                ],
              ),

              15.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    order["date"]!,
                    style: getMediumStyle(
                      color: ColorManager.gray,
                      fontSize: 14.sp,
                    ),
                  ),
                  Text(
                    order["price"]!,
                    style: getBoldStyle(
                      color: ColorManager.primary,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
