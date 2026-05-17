import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';
import 'package:chefaa/core/widget/inspector_bottom_sheet_container.dart';
import 'package:flutter/material.dart';
import 'package:chefaa/presentation/doctor/layout/patients/presentation/widgets/prescription_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrescriptionHistoryBottomSheet extends StatelessWidget {
  final List<Map<String, String>> medications;

  const PrescriptionHistoryBottomSheet({
    super.key,
    required this.medications,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p16),
      child: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const InspectorBottomSheetContainer(),

              10.verticalSpace,

              Text(
                "Prescription Details",
                style: getBoldStyle(
                  color: ColorManager.black,
                  fontSize: 20.sp,
                ),
              ),

              10.verticalSpace,

              Expanded(
                child: PrescriptionCard(
                  medications: medications,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}