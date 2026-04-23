import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'confirm_booking_card_decoration.dart';

class PaymentMethodsCard extends StatelessWidget {
  const PaymentMethodsCard({
    super.key,
    required this.title,
    required this.image,
    required this.isSelected,
    required this.onTap,
    this.isGroupHeader = false,
  });

  final String title;
  final String image;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isGroupHeader;

  @override
  Widget build(BuildContext context) {
    final borderColor = isSelected ? ColorManager.primary : ColorManager.input;
    final borderWidth = isSelected ? 2.0 : 1.0;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          height: 85.h,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: isGroupHeader
                ? const BorderRadius.vertical(top: Radius.circular(16))
                : BorderRadius.circular(16),
            border: isGroupHeader
                ? Border(
                    left: BorderSide(color: borderColor, width: borderWidth),
                    right: BorderSide(color: borderColor, width: borderWidth),
                    top: BorderSide(color: borderColor, width: borderWidth),
                    bottom: BorderSide.none,
                  )
                : Border.all(color: borderColor, width: borderWidth),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 50,
                padding: const EdgeInsets.all(4),
                decoration: confirmBookingCardDecoration(isSelected: isSelected),
                child: Image.asset(image, fit: BoxFit.cover),
              ),
              24.horizontalSpace,
              Expanded(
                child: Text(
                  title,
                  style: getBoldStyle(color: ColorManager.black, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

