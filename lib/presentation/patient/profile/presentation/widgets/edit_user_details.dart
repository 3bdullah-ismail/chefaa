import 'package:chefaa/presentation/patient/profile/presentation/manager/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/widget/custom_btn.dart';
import '../../../../../core/widget/custom_dropdown_btn.dart';
import '../../../../../core/widget/custom_text_field.dart';
import '../../../../../core/widget/loading.dart';
import 'item_container.dart';

class EditUserDetails extends StatefulWidget {
  const EditUserDetails({super.key});

  @override
  State<EditUserDetails> createState() => _EditUserDetailsState();
}

class _EditUserDetailsState extends State<EditUserDetails> {
  bool isReadOnly = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileCubit>().getProfileData();
    });
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
                isReadOnly ? "Basic Details" : "Edit Basic Details",
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
                listener: (context, state) {
                  if (state is GetProfileDataLoadingState ||
                      state is UpdateProfileDataLoadingState) {
                    Loading.show(context);
                  } else if (state is GetProfileDataSuccessState) {
                    Loading.hide(context);
                    final user = state.profileData;
                    if (cubit.nameController.text.isEmpty) {
                      cubit.nameController.text = user.userName ?? '';
                    }
                    if (cubit.ageController.text.isEmpty) {
                      cubit.ageController.text = user.age?.toString() ?? '';
                    }
                    if (cubit.weightController.text.isEmpty) {
                      cubit.weightController.text =
                          user.userWeight?.toString() ?? '';
                    }
                    if (cubit.heightController.text.isEmpty) {
                      cubit.heightController.text =
                          user.userHeight?.toString() ?? '';
                    }
                    if (cubit.gender.isEmpty) {
                      cubit.gender = user.userGender ?? "";
                    }
                  } else if (state is UpdateProfileDataSuccessState) {
                    Loading.hide(context);
                    final user = state.profileData;
                    cubit.nameController.text = user.userName ?? '';
                    cubit.ageController.text = user.age?.toString() ?? '';
                    cubit.weightController.text =
                        user.userWeight?.toString() ?? '';
                    cubit.heightController.text =
                        user.userHeight?.toString() ?? '';
                    cubit.gender = user.userGender ?? "";
                    setState(() {
                      isReadOnly = true;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Profile updated successfully')),
                    );
                  } else if (state is GetProfileDataFailureState) {
                    Loading.hide(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  } else if (state is UpdateProfileDataFailureState) {
                    Loading.hide(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  }
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name",
                      style: getMediumStyle(
                        color: ColorManager.black,
                        fontSize: 16,
                      ),
                    ),
                    8.verticalSpace,
                    CustomTextField(
                      controller: cubit.nameController,
                      text: "Name",
                      isReadOnly: isReadOnly,
                    ),
                    16.verticalSpace,
                    Text(
                      "Gender",
                      style: getMediumStyle(
                        color: ColorManager.black,
                        fontSize: 16,
                      ),
                    ),
                    8.verticalSpace,
                    CustomDropDownBtn(
                      items: const ["Male", "Female"],
                      hintText: cubit.gender,
                      value: cubit.gender,
                      onChanged: isReadOnly
                          ? null
                          : (value) {
                              setState(() {
                                cubit.gender = value!;
                              });
                            },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select your gender';
                        }
                        return null;
                      },
                    ),
                    16.verticalSpace,
                    Text(
                      "Age",
                      style: getMediumStyle(
                        color: ColorManager.black,
                        fontSize: 16,
                      ),
                    ),
                    8.verticalSpace,
                    CustomTextField(
                      completeData: true,
                      controller: cubit.ageController,
                      text: "Age",
                      isReadOnly: isReadOnly,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your weight';
                        }
                        return null;
                      },
                    ),
                    16.verticalSpace,
                    Text(
                      "Weight",
                      style: getMediumStyle(
                        color: ColorManager.black,
                        fontSize: 16,
                      ),
                    ),
                    8.verticalSpace,
                    CustomTextField(
                      suffixText: "kg",
                      completeData: true,
                      controller: cubit.weightController,
                      text: "Weight",
                      isReadOnly: isReadOnly,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your weight';
                        }
                        return null;
                      },
                    ),

                    16.verticalSpace,
                    Text(
                      "Height",
                      style: getMediumStyle(
                        color: ColorManager.black,
                        fontSize: 16,
                      ),
                    ),
                    8.verticalSpace,
                    CustomTextField(
                      suffixText: "cm",
                      completeData: true,
                      controller: cubit.heightController,
                      text: "Height",
                      isReadOnly: isReadOnly,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your height';
                        }
                        return null;
                      },
                    ),
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
                cubit.updateProfileData();
              },
            ),
        ],
      ),
    );
  }
}
