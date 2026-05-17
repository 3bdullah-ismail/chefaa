import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/widget/custom_btn.dart';
import 'package:chefaa/presentation/doctor/layout/patients/presentation/widgets/lab_tests.dart';
import 'package:chefaa/presentation/doctor/layout/patients/presentation/widgets/medication_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/resources/color_manager.dart';
import '../../../../../../core/resources/values_manager.dart';
import 'add_prescription_bottom_sheet.dart';

class PrescriptionCard extends StatefulWidget {
  final List<Map<String, String>> medications;

  const PrescriptionCard({super.key, required this.medications});

  @override
  State<PrescriptionCard> createState() => _PrescriptionCardState();
}

class _PrescriptionCardState extends State<PrescriptionCard> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(
          top: AppPadding.p20,
          left: AppPadding.p10,
          right: AppPadding.p10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomBtn(
              text: "Add Prescription",
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: ColorManager.lightGray,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  builder: (context) {
                    return const AddPrescriptionBottomSheet();
                  },
                );
              },
            ),
            30.verticalSpace,
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: ColorManager.lightGray,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: ColorManager.primary.withAlpha(30)),
                boxShadow: [
                  BoxShadow(
                    color: ColorManager.black.withAlpha(50),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 44.w,
                    height: 44.w,
                    decoration: BoxDecoration(
                      color: ColorManager.primary.withAlpha(30),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(
                      Icons.event,
                      color: ColorManager.primary,
                      size: 22.sp,
                    ),
                  ),

                  12.horizontalSpace,

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Next Visit",
                          style: getBoldStyle(
                            color: ColorManager.primary,
                            fontSize: 17.sp,
                          ),
                        ),
                        4.verticalSpace,
                        Text(
                          "20 September 2024",
                          style: getBoldStyle(
                            color: ColorManager.black,
                            fontSize: 15.sp,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: ColorManager.primary.withAlpha(20),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      "Upcoming",
                      style: getMediumStyle(
                        color: ColorManager.primary,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            30.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Medication Items",
                    style: getBoldStyle(
                      color: ColorManager.black,
                      fontSize: 22.sp,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p12,
                    vertical: AppPadding.p4,
                  ),
                  decoration: BoxDecoration(
                    color: ColorManager.primary.withAlpha(50),
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                  child: Text(
                    "${widget.medications.length} items",
                    style: getMediumStyle(
                      color: ColorManager.primary,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
              ],
            ),
            15.verticalSpace,

            ConstrainedBox(
              constraints: BoxConstraints(minHeight: 80.h, maxHeight: 250.h),
              child: Container(
                padding: const EdgeInsets.all(AppPadding.p16),
                decoration: BoxDecoration(
                  color: ColorManager.lightGray,
                  borderRadius: BorderRadius.circular(25.r),
                  boxShadow: [
                    BoxShadow(
                      color: ColorManager.black.withAlpha(80),
                      blurRadius: 10,
                    ),
                  ],
                ),

                child: RawScrollbar(
                  controller: _scrollController,
                  thumbVisibility: true,
                  trackColor: ColorManager.input.withAlpha(85),
                  thickness: 5,
                  radius: const Radius.circular(25),
                  interactive: true,

                  child: ListView.separated(
                    shrinkWrap: true,
                    primary: false,
                    controller: _scrollController,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(right: AppPadding.p16),
                    itemCount: widget.medications.length,

                    separatorBuilder: (_, _) =>
                        const Divider(color: ColorManager.input, thickness: 1),

                    itemBuilder: (context, index) {
                      final item = widget.medications[index];

                      return MedicationItems(
                        medicationName: item['name'] ?? "",
                        dosage: item['dosage'] ?? "",
                        frequency: item['frequency'] ?? "",
                        duration: item['duration'] ?? "",
                      );
                    },
                  ),
                ),
              ),
            ),
            30.verticalSpace,
            Text(
              "Lab Tests",
              style: getBoldStyle(color: ColorManager.black, fontSize: 22.sp),
            ),
            15.verticalSpace,
            const LabTests(),
            30.verticalSpace,
            Text(
              "Imaging / Radiology Tests",
              style: getBoldStyle(color: ColorManager.black, fontSize: 22.sp),
            ),
            15.verticalSpace,
            const LabTests(),
            30.verticalSpace,
            Text(
              "Doctor Notes",
              style: getBoldStyle(color: ColorManager.black, fontSize: 22.sp),
            ),
            15.verticalSpace,
            Container(
              padding: const EdgeInsets.all(AppPadding.p20),
              decoration: BoxDecoration(
                color: ColorManager.lightGray,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: ColorManager.primary.withAlpha(50)),
                boxShadow: [
                  BoxShadow(
                    color: ColorManager.black.withAlpha(50),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Text(
                "Take the medications as prescribed and follow up in 2 weeks for a check-up. Monitor your blood pressure daily and report any significant changes. Maintain a healthy diet and exercise regularly.",
                style: getMediumStyle(
                  color: ColorManager.black,
                  fontSize: 17.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
