import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chefaa/core/extensions/build_ex.dart';
import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/resources/assets_manager.dart';
import 'package:chefaa/presentation/facility/auth/presentation/manager/facility_auth_cubit.dart';
import 'labeled_text_field.dart';

class MedicalLeadershipCard extends StatelessWidget {
  final FacilityAuthCubit cubit;

  const MedicalLeadershipCard({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      width: context.width * 0.9,
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(ImageAssets.hospitalist, width: 56),
              const SizedBox(width: 8),
              Text(
                "Medical Leadership",
                style: getSemiBoldStyle(
                  color: ColorManager.black,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 48),
          LabeledTextField(
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            label: "Medical Director Name",
            controller: cubit.medicalDirectorName,
            hint: "Doctor’s full name",
          ),
          const SizedBox(height: 48),
          LabeledTextField(
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            label: "Director’s Professional ID",
            controller: cubit.directorProfessionalId,
            hint: "ID number",
          ),
        ],
      ),
    );
  }
}
