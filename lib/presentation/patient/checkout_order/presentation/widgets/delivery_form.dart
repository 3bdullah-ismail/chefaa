import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/assets_manager.dart';
import '../../../../../core/widget/custom_text_field.dart';

class DeliveryForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController cityController;
  final TextEditingController streetController;

  const DeliveryForm({
    super.key,
    required this.nameController,
    required this.phoneController,
    required this.cityController,
    required this.streetController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          controller: nameController,
          text: "Full Name",
          prefixIcon: IconsAssets.userIcon,
        ),
        10.verticalSpace,
        CustomTextField(
          controller: phoneController,
          text: "Phone Number",
          prefixIcon: IconsAssets.phoneIcon,
        ),
        10.verticalSpace,
        CustomTextField(
          controller: cityController,
          text: "City",
          prefixIcon: SvgAssets.map,
        ),
        10.verticalSpace,
        CustomTextField(
          controller: streetController,
          text: "Street Address",
          prefixIcon: SvgAssets.map,
        ),
      ],
    );
  }
}
