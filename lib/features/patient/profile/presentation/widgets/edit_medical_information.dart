import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/widgets/custom_btn.dart';
import 'package:chefaa/core/widgets/custom_text_field.dart';
import 'package:chefaa/features/patient/profile/presentation/manager/profile_cubit.dart';
import 'item_container.dart';

class EditMedicalInformation extends StatefulWidget {
  const EditMedicalInformation({super.key});

  @override
  State<EditMedicalInformation> createState() => _EditMedicalInformationState();
}

class _EditMedicalInformationState extends State<EditMedicalInformation> {
  bool isReadOnly = true;

  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getProfileData();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = ProfileCubit.get(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isReadOnly ? "Medical Information" : "Edit Medical Information",
                style: getSemiBoldStyle(
                  color: ColorManager.black,
                  fontSize: 20,
                ),
              ),
              if (isReadOnly)
                InkWell(
                  onTap: () {
                    setState(() {
                      isReadOnly = false;
                    });
                  },
                  child: SvgPicture.asset("assets/svg_images/edit.svg"),
                ),
            ],
          ),
          24.verticalSpace,
          ItemContainer(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: BlocListener<ProfileCubit, ProfileState>(
                listenWhen: (previous, current) => current is GetProfileDataSuccessState,
                listener: (context, state) {
                  if (state is GetProfileDataSuccessState) {
                    var user = state.profileData;
                    cubit.bloodTypeController.text =
                        cubit.bloodTypeController.text.isEmpty
                        ? user.userBloodType ?? ''
                        : cubit.bloodTypeController.text;
                    cubit.chronicController.text =
                        cubit.chronicController.text.isEmpty
                        ? user.chronicConditionsList?.join(", ") ?? ""
                        : cubit.chronicController.text;
                    cubit.allergiesController.text =
                        cubit.allergiesController.text.isEmpty
                        ? user.allergiesList?.join(", ") ?? ""
                        : cubit.allergiesController.text;
                  }
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Blood Type",
                      style: TextStyle(
                        color: ColorManager.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    12.verticalSpace,

                    CustomTextField(
                      completeData: true,
                      controller: cubit.bloodTypeController,
                      isReadOnly: isReadOnly,
                      text: "Blood Type with ( + or - )",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your blood type';
                        }
                        return null;
                      },
                    ),
                    16.verticalSpace,
                    const Text(
                      "Allergies",
                      style: TextStyle(
                        color: ColorManager.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    12.verticalSpace,

                    CustomTextField(
                      completeData: true,
                      controller: cubit.allergiesController,
                      isReadOnly: isReadOnly,
                      text: " ",
                    ),
                    16.verticalSpace,
                    const Text(
                      "Chronic conditions",
                      style: TextStyle(
                        color: ColorManager.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    12.verticalSpace,

                    CustomTextField(
                      completeData: true,
                      controller: cubit.chronicController,
                      isReadOnly: isReadOnly,
                      text: " ",
                    ),
                    16.verticalSpace,
                  ],
                ),
              ),
            ),
          ),
          32.verticalSpace,
          if (!isReadOnly)
            CustomBtn(
              text: "Save Changes",
              onPressed: () {
                cubit.updateMedicalInformation();
                setState(() {
                  isReadOnly = true;
                });
              },
            ),
        ],
      ),
    );
  }
}
