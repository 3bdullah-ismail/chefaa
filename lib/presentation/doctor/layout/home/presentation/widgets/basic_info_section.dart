import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/widget/bottom_sheet_text_field_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/resources/color_manager.dart';
import '../../../../../patient/profile/presentation/widgets/item_container.dart';

class BasicInfoSection extends StatelessWidget {
  const BasicInfoSection({
    super.key,
    required this.clinicNameController,
    required this.cityController,
    required this.consultationPriceController,
    required this.addressController,
    required this.latitudeController,
    required this.longitudeController,
    required this.licenseController,
  });
  final TextEditingController clinicNameController;
  final TextEditingController cityController;

  final TextEditingController consultationPriceController;

  final TextEditingController addressController;


  final TextEditingController latitudeController;

  final TextEditingController longitudeController;
  final TextEditingController licenseController;

  @override
  Widget build(BuildContext context) {
    return ItemContainer(
      isMedication: true,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Basic Information",
              style: getBoldStyle(color: ColorManager.black, fontSize: 18),
            ),

            20.verticalSpace,

            BottomSheetTextFieldItem(
              title: "Clinic Name",
              controller: clinicNameController,
              hint: "e.g. Dr. Ahmed's Clinic",
            ),

            16.verticalSpace,

            Row(
              children: [
                Expanded(
                  child: BottomSheetTextFieldItem(
                    title: "City",
                    controller: cityController,
                    hint: "e.g. Cairo",
                  ),
                ),

                12.horizontalSpace,

                Expanded(
                  child: BottomSheetTextFieldItem(
                    title: "Consultation Price",
                    controller: consultationPriceController,
                    hint: "e.g. EGP 200",
                  ),
                ),
              ],
            ),

            16.verticalSpace,

            BottomSheetTextFieldItem(
              title: "Address",
              controller: addressController,
              hint: "e.g. 123 Main St, Cairo",
            ),

            16.verticalSpace,


            Row(
              children: [
                Expanded(
                  child: BottomSheetTextFieldItem(
                    title: "Latitude",
                    controller: latitudeController,
                    hint: "e.g. 30.0444",
                  ),
                ),

                12.horizontalSpace,

                Expanded(
                  child: BottomSheetTextFieldItem(
                    title: "Longitude",
                    controller: longitudeController,
                    hint: "e.g. 31.2357",
                  ),
                ),
              ],
            ),

            16.verticalSpace,

            BottomSheetTextFieldItem(
              title: "Operation License Number",
              controller: licenseController,
              hint: "e.g. 123456789",
            ),
          ],
        ),
      ),
    );
  }
}
