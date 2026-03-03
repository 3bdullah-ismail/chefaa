import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:chefaa/core/resources/assets_manager.dart';
import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/constants_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';
import 'package:chefaa/core/widget/custom_app_bar.dart';
import 'package:chefaa/core/widget/custom_btn.dart';
import 'package:chefaa/core/widget/custom_text_field.dart';
import 'package:chefaa/core/widget/loading_dialog.dart';
import 'package:chefaa/core/widget/terms_of_service.dart';
import 'package:chefaa/core/widget/upload_container.dart';
import 'package:chefaa/core/widget/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/config/get_config.dart';
import '../../../../../core/manager/file_handler_cubit.dart';
import '../../../../../core/routes/app_routes_names.dart';
import '../manager/pharmacy_cubit.dart';
import '../manager/pharmacy_state.dart';
import '../../../../../core/widget/license_formatter.dart';

class PharmacySignUpPage extends StatefulWidget {
  const PharmacySignUpPage({super.key});

  @override
  State<PharmacySignUpPage> createState() => _PharmacySignUpPageState();
}

class _PharmacySignUpPageState extends State<PharmacySignUpPage> {
  bool isChecked = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<PharmacyCubit>(),
      child: Scaffold(
        backgroundColor: const Color(0xffe1e3ec),
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(170),
          child: CustomAppBar(),
        ),
        body: BlocConsumer<PharmacyCubit, PharmacyState>(
          listener: (context, state) {
            if (state is PharmacyLoadingState) {
              showDialog(
                context: context,
                builder: (context) => const LoadingDialog(),
              );
            } else if (state is PharmacyErrorState) {
              AnimatedSnackBar.rectangle(
                AppConstants.error,
                state.message,
                type: AnimatedSnackBarType.error,
                brightness: Brightness.dark,
              ).show(context);
            } else if (state is PharmacySuccessState) {
              AnimatedSnackBar.rectangle(
                AppConstants.success,
                "Welcome Pharmacy. ${state.pharmacy.name}!",
                type: AnimatedSnackBarType.success,
                brightness: Brightness.dark,
              ).show(context);
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutesNames.patientLayout,
                (route) => false,
              );
            } else {}
          },
          builder: (context, state) {
            var cubit = PharmacyCubit.get(context);
            return SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p18,
                    vertical: AppPadding.p16,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(AppPadding.p18),
                          margin: const EdgeInsets.all(AppMargin.m8),
                          decoration: BoxDecoration(
                            color: ColorManager.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              20.verticalSpace,
                              const Text(
                                "Pharmacy Name",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              10.verticalSpace,
                              CustomTextField(
                                validator: Validators.validateUsername,
                                controller: cubit.username,
                                text: "Full Pharmacy legal name",
                              ),
                              20.verticalSpace,
                              const Text(
                                AppConstants.phoneNumber,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              10.verticalSpace,
                              CustomTextField(
                                validator: Validators.validatePhone,
                                prefixIcon: IconsAssets.phoneIcon,
                                controller: cubit.phoneNumber,
                                text: AppConstants.phoneHint,
                              ),
                              20.verticalSpace,
                              const Text(
                                AppConstants.workEmail,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              10.verticalSpace,
                              CustomTextField(
                                validator: Validators.validateEmail,
                                prefixIcon: IconsAssets.emailIcon,
                                controller: cubit.email,
                                text: AppConstants.emailPharmacyHint,
                              ),
                              20.verticalSpace,
                              const Text(
                                AppConstants.password,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              10.verticalSpace,
                              CustomTextField(
                                validator: Validators.validatePassword,
                                prefixIcon: IconsAssets.passwordIcon,
                                controller: cubit.password,
                                text: AppConstants.enterPassword,
                              ),
                              20.verticalSpace,
                              const Text(
                                AppConstants.confirmPassword,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              10.verticalSpace,
                              CustomTextField(
                                validator: (value) =>
                                    Validators.validateConfirmPassword(
                                      value,
                                      cubit.password.text,
                                    ),
                                prefixIcon: IconsAssets.passwordIcon,
                                controller: cubit.confirmPasswordController,
                                text: AppConstants.reEnterPassword,
                              ),
                              20.verticalSpace,
                              const Text(
                                AppConstants.commercialLicenseNumber,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              10.verticalSpace,
                              CustomTextField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'[a-zA-Z0-9]'),
                                  ),
                                  LicenseFormatter(),
                                ],
                                validator: Validators.validateLicense,
                                controller: cubit.registerNumber,
                                text: AppConstants.licenseHint,
                              ),
                              20.verticalSpace,
                              const Text(
                                AppConstants.medicalLicenseUpload,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              10.verticalSpace,
                              const UploadCard(
                                text: AppConstants.uploadYourLicence,
                                dialogText:
                                    AppConstants.uploadYourMedicalLicence,
                                fileName: AppConstants.licensePdf,
                              ),
                            ],
                          ),
                        ),
                        40.verticalSpace,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 27.h,
                              width: 27.w,
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  setState(() {
                                    isChecked = !isChecked;
                                  });
                                },
                                icon: isChecked
                                    ? SvgPicture.asset(
                                        IconsAssets.checkIconActive,
                                      )
                                    : SvgPicture.asset(
                                        IconsAssets.checkIconInactive,
                                      ),
                              ),
                            ),
                            14.horizontalSpace,
                            const Expanded(child: TermsOfService()),
                          ],
                        ),
                        25.verticalSpace,

                        CustomBtn(
                          isDisabled:
                              !isChecked || !_formKey.currentState!.validate(),
                          text: AppConstants.submitForVerification,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              final file = context
                                  .read<FileHandlerCubit>()
                                  .pickedFile;

                              cubit.pharmacySignUp(medicalLicence: file);
                            }
                          },
                        ),
                      ],
                    ),
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
