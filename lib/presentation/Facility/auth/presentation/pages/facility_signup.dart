import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:chefaa/core/extensions/build_ex.dart';
import 'package:chefaa/core/resources/assets_manager.dart';
import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/widget/already_have_account.dart';
import 'package:chefaa/core/widget/custom_btn.dart';
import 'package:chefaa/core/widget/custom_dropdown_btn.dart';
import 'package:chefaa/core/widget/terms_of_service.dart';
import 'package:chefaa/core/widget/upload_container.dart';
import 'package:chefaa/core/widget/validators.dart';
import 'package:chefaa/presentation/Facility/auth/presentation/manager/facility_auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/config/get_config.dart';
import '../../../../../core/manager/file_handler_cubit.dart';
import '../../../../../core/resources/constants_manager.dart';
import '../../../../../core/widget/custom_app_bar.dart';
import '../../../../../core/widget/license_formatter.dart';
import '../../../../../core/widget/loading_dialog.dart';
import '../widgets/labeled_text_field.dart';

class FacilitySignup extends StatefulWidget {
  const FacilitySignup({super.key});

  @override
  State<FacilitySignup> createState() => _FacilitySignupState();
}

class _FacilitySignupState extends State<FacilitySignup> {
  bool isChecked = false;
  final _formKey = GlobalKey<FormState>();
  late final FacilityAuthCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<FacilityAuthCubit>();
    FileHandlerCubit.get(context).clearFile();
  }

  @override
  void dispose() {
    _cubit.close();
    FileHandlerCubit.get(context).clearFile();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        backgroundColor: ColorManager.input,
        appBar: CustomAppBar(
          preferredHeight: 175.h,
          child: Center(
            child: Image.asset("assets/images/chefaa.png", height: 50.h),
          ),
        ),
        body: BlocConsumer<FacilityAuthCubit, FacilityAuthState>(
          listener: (context, state) {
            if (state is SignUpLoading) {
              showDialog(
                context: context,
                builder: (context) => const LoadingDialog(),
              );
            } else if (state is SingUpFailure) {
              AnimatedSnackBar.rectangle(
                AppConstants.error,
                state.errorMessage,
                type: AnimatedSnackBarType.error,
                brightness: Brightness.dark,
              ).show(context);
            } else if (state is SingUpSuccess) {
              AnimatedSnackBar.rectangle(
                AppConstants.success,
                "Welcome  ${state.userName}!",
                type: AnimatedSnackBarType.success,
                brightness: Brightness.dark,
              ).show(context);
            } else {}
          },
          builder: (context, state) {
            var cubit = FacilityAuthCubit.get(context);
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 48),
                      Center(
                        child: Container(
                          padding: const EdgeInsets.all(24),
                          width: context.width * 0.9,
                          decoration: BoxDecoration(
                            color: ColorManager.white,
                            borderRadius: BorderRadius.circular(18.r),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppConstants.facilityType,
                                style: getMediumStyle(
                                  color: ColorManager.black,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 16),
                              CustomDropDownBtn(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please select The Type';
                                  }
                                  return null;
                                },
                                value: cubit.facilityType,
                                onChanged: (value) {
                                  setState(() {
                                    cubit.facilityType = value;
                                  });
                                },
                                items: const ["Lab", "Radiology center"],
                                hintText: 'choose lab or radiology',
                              ),
                              // Container(
                              //   padding: const EdgeInsets.symmetric(
                              //     horizontal: 20,
                              //   ),
                              //   decoration: BoxDecoration(
                              //     color: ColorManager.lightGray,
                              //     borderRadius: BorderRadius.circular(50),
                              //     border: Border.all(color: ColorManager.input),
                              //   ),
                              //   child: DropdownButtonHideUnderline(
                              //     child: DropdownButton<String>(
                              //       dropdownColor: Colors.white,
                              //       value: cubit.facilityType,
                              //       isExpanded: true,
                              //       hint: Text(
                              //         "choose lab or radiology",
                              //         style: TextStyle(
                              //           color: Colors.blueGrey.shade300,
                              //         ),
                              //       ),
                              //       icon: const Icon(Icons.keyboard_arrow_down),
                              //       items: <String>['Lab', 'Radiology center']
                              //           .map((String value) {
                              //             return DropdownMenuItem<String>(
                              //               value: value,
                              //               child: Text(value),
                              //             );
                              //           })
                              //           .toList(),
                              //       onChanged: (newValue) {
                              //         setState(() {
                              //           cubit.facilityType = newValue;
                              //         });
                              //       },
                              //     ),
                              //   ),
                              // ),
                              const SizedBox(height: 16),
                              // LabeledTextField(
                              //   validator: Validators.nameValidator,
                              //   label: AppConstants.facilityName,
                              //   controller: cubit.name,
                              //   hint: "e.g. Alpa Labs/Scan",
                              // ),
                              LabeledTextField(
                                keyboardType: TextInputType.name,
                                label: AppConstants.facilityName,
                                controller: cubit.username,
                                hint: "e.g. Alpa Labs/Scan",
                                textInputAction: TextInputAction.next,
                              ),
                              LabeledTextField(
                                keyboardType: TextInputType.phone,
                                validator: Validators.validatePhone,
                                label: AppConstants.phoneNumber,
                                controller: cubit.phoneNumber,
                                hint: AppConstants.phoneHint,
                                prefixIcon: IconsAssets.phoneIcon,
                                textInputAction: TextInputAction.next,
                              ),
                              LabeledTextField(
                                keyboardType: TextInputType.emailAddress,
                                validator: Validators.validateEmail,
                                label: AppConstants.workEmail,
                                controller: cubit.email,
                                hint: AppConstants.emailFacilityHint,
                                prefixIcon: IconsAssets.emailIcon,
                                textInputAction: TextInputAction.next,
                              ),
                              LabeledTextField(
                                keyboardType: TextInputType.visiblePassword,
                                validator: Validators.validatePassword,
                                label: AppConstants.password,
                                controller: cubit.password,
                                hint: AppConstants.enterPassword,
                                isPassword: true,
                                prefixIcon: IconsAssets.passwordIcon,
                                textInputAction: TextInputAction.next,
                              ),
                              LabeledTextField(
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.next,
                                validator: (value) =>
                                    Validators.validateConfirmPassword(
                                      value,
                                      cubit.password.text,
                                    ),
                                label: AppConstants.confirmPassword,
                                controller: cubit.confirmPasswordController,
                                hint: AppConstants.reEnterPassword,
                                isPassword: true,
                                prefixIcon: IconsAssets.passwordIcon,
                              ),
                              LabeledTextField(
                                textInputAction: TextInputAction.done,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'[a-zA-Z0-9]'),
                                  ),
                                  LicenseFormatter(),
                                ],
                                validator: Validators.validateLicense,
                                label: AppConstants.commercialLicenseNumber,
                                controller: cubit.commercialRegisterNumber,
                                hint: AppConstants.licenseHint,
                              ),
                              const SizedBox(height: 22),
                              Text(
                                AppConstants.medicalLicenseUpload,
                                style: getMediumStyle(
                                  color: ColorManager.black,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 16),
                              const UploadCard(
                                text: AppConstants.uploadYourLicence,
                                dialogText:
                                    AppConstants.uploadYourMedicalLicence,
                                fileName: AppConstants.licensePdf,
                              ),
                              const SizedBox(height: 22),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Container(
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
                      ),
                      const SizedBox(height: 25),
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                isChecked = !isChecked;
                                setState(() {});
                              },
                              child: isChecked
                                  ? SvgPicture.asset(
                                      IconsAssets.checkIconActive,
                                    )
                                  : SvgPicture.asset(
                                      IconsAssets.checkIconInactive,
                                    ),
                            ),
                            const SizedBox(width: 12),
                            const Expanded(child: TermsOfService()),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      CustomBtn(
                        isDisabled: !isChecked || state is SignUpLoading,
                        text: AppConstants.submitForVerification,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final file = context
                                .read<FileHandlerCubit>()
                                .pickedFile;

                            cubit.signUp(medicalLicence: file);
                          }
                        },
                      ),
                      const SizedBox(height: 15),
                      const AlreadyHaveAccount(),
                      const SizedBox(height: 25),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
