import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';
import 'package:chefaa/core/widget/custom_btn.dart';
import 'package:chefaa/core/widget/custom_text_field.dart';
import 'package:chefaa/core/widget/inspector_bottom_sheet_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddPrescriptionBottomSheet extends StatefulWidget {
  const AddPrescriptionBottomSheet({super.key});

  @override
  State<AddPrescriptionBottomSheet> createState() =>
      _AddPrescriptionBottomSheetState();
}

class _AddPrescriptionBottomSheetState
    extends State<AddPrescriptionBottomSheet> {
  final diagnosisController = TextEditingController();
  final medicationNameController = TextEditingController();
  final dosageController = TextEditingController();
  final frequencyController = TextEditingController();
  final durationController = TextEditingController();
  final labTestsController = TextEditingController();
  final imagingController = TextEditingController();
  final nextVisitController = TextEditingController();
  final doctorNotesController = TextEditingController();

  Widget sectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Text(
        title,
        style: getBoldStyle(color: ColorManager.black, fontSize: 20.sp),
      ),
    );
  }

  Widget textField({
    required String hint,
    required TextEditingController controller,
    int maxLines = 1,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: ColorManager.input.withAlpha(60),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.r),
            borderSide: const BorderSide(color: ColorManager.gray),
          ),
          

        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * .8,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p20,
              vertical: AppPadding.p16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const InspectorBottomSheetContainer(),

                Text(
                  "Add Prescription",
                  style: getBoldStyle(
                    color: ColorManager.black,
                    fontSize: 24.sp,
                  ),
                ),

                6.verticalSpace,

                Text(
                  "Add patient prescription details",
                  style: getMediumStyle(
                    color: ColorManager.gray,
                    fontSize: 14.sp,
                  ),
                ),

                24.verticalSpace,

                sectionTitle("Diagnosis"),

                CustomTextField(
                  controller: diagnosisController,
                  text: "Enter diagnosis details",
                ),
                10.verticalSpace,
                sectionTitle("Medication"),

                CustomTextField(
                  controller: medicationNameController,
                  text: "Enter medication name",
                ),
                10.verticalSpace,

                CustomTextField(
                  controller: dosageController,
                  text: "dosage (e.g., 500mg)",
                ),
                10.verticalSpace,
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: frequencyController,
                        text: "Frequency (e.g., twice a day)",
                      ),
                    ),
                    15.horizontalSpace,
                    Expanded(
                      child: CustomTextField(
                        controller: durationController,
                        text: "Duration (e.g., 7 days)",
                      ),
                    ),
                  ],
                ),

                10.verticalSpace,
                sectionTitle("Lab Tests"),
                textField(
                  hint: "Enter lab tests",
                  controller: labTestsController,
                  maxLines: 3,
                ),
                sectionTitle("Imaging / Radiology Tests"),
                textField(
                  hint: "Enter imaging tests",
                  controller: imagingController,
                  maxLines: 3,
                ),
                  10.verticalSpace,
                sectionTitle("Next Visit"),

                CustomTextField(
                  text: "Next visit date",
                  controller: nextVisitController,
                ),
                  20.verticalSpace,
                sectionTitle("Doctor Notes"),

                textField(
                  hint: "Write notes...",
                  controller: doctorNotesController,
                  maxLines: 5,
                ),

                20.verticalSpace,

                CustomBtn(text: "Add Prescription", onPressed: () {}),

                20.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
