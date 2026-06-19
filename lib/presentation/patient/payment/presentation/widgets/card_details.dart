import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/assets_manager.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/resources/values_manager.dart';
import '../../../../../core/widget/custom_text_field.dart';

class CardDetails extends StatelessWidget {
  final TextEditingController cardNumber;
  final TextEditingController holder;
  final TextEditingController expiry;

  final TextEditingController cvv;

  const CardDetails({
    super.key,
    required this.cardNumber,
    required this.holder,
    required this.expiry,
    required this.cvv,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        color: ColorManager.lightGray,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(80),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Card Details",
            style: getBoldStyle(color: ColorManager.black, fontSize: 18.sp),
          ),
          16.verticalSpace,
          CustomTextField(
            controller: cardNumber,
            text: "Card Number",
            prefixIcon: SvgAssets.wallet,
          ),
          10.verticalSpace,

          CustomTextField(
            controller: holder,
            text: "Card Holder",
            prefixIcon: SvgAssets.profile,
          ),
          10.verticalSpace,
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  controller: expiry,
                  text: "MM/YY",
                  prefixIcon: SvgAssets.appointment,
                ),
              ),
              10.horizontalSpace,
              Expanded(
                child: CustomTextField(
                  controller: cvv,
                  text: "CVV",
                  prefixIcon: IconsAssets.passwordIcon,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
