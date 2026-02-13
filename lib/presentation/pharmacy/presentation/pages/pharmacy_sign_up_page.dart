import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:chefaa/core/resources/assets_manager.dart';
import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';
import 'package:chefaa/core/widget/custom_app_bar.dart';
import 'package:chefaa/core/widget/custom_btn.dart';
import 'package:chefaa/core/widget/custom_text_field.dart';
import 'package:chefaa/core/widget/validators.dart';
import 'package:chefaa/presentation/pharmacy/presentation/widgets/upload_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/config/get_config.dart';
import '../../../../core/routes/app_routes_names.dart';
import '../manager/pharmacy_cubit.dart';
import '../manager/pharmacy_state.dart';
import '../widgets/loading_dialog.dart';

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
                builder: (context) => const LoadingPharDialog(),
              );
            }
            else if (state is PharmacyErrorState) {
              AnimatedSnackBar.rectangle(
                'Error',
                state.message,
                type: AnimatedSnackBarType.error,
                brightness: Brightness.dark,
              ).show(context);
            }
            else if (state is PharmacySuccessState) {
              AnimatedSnackBar.rectangle(
                'Success',
                "Welcome Pharmacy. ${state.pharmacy.name}!",
                type: AnimatedSnackBarType.success,
                brightness: Brightness.dark,
              ).show(context);
              Navigator.pushNamedAndRemoveUntil(
                  context, AppRoutesNames.layout, (route) => false);
            } else {}
          },
          builder: (context, state) {
            var cubit = PharmacyCubit.get(context);
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.p18,
                  vertical: AppPadding.p16,
                ),
                child: SafeArea(
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
                                "Phone Number",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              10.verticalSpace,
                              CustomTextField(
                                validator: Validators.validatePhone,
                                prefixIcon: IconsAssets.phoneIconInactive,
                                controller: cubit.phoneNumber,
                                text: "+20  xxxxxxxx",
                              ),
                              20.verticalSpace,
                              const Text(
                                "Work Email",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              10.verticalSpace,
                              CustomTextField(
                                validator: Validators.validateEmail,
                                prefixIcon: IconsAssets.emailIconInactive,
                                controller: cubit.email,
                                text: "contact@pharmacy.com",
                              ),
                              20.verticalSpace,
                              const Text(
                                "Password",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              10.verticalSpace,
                              CustomTextField(
                                validator: Validators.validatePassword,
                                prefixIcon: IconsAssets.passwordIconInactive,
                                controller: cubit.password,
                                text: "Enter your password",
                              ),
                              20.verticalSpace,
                              const Text(
                                "Confirm Password",
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
                                prefixIcon: IconsAssets.passwordIconInactive,
                                controller: cubit.confirmPasswordController,
                                text: "Re-enter your password",
                              ),
                              20.verticalSpace,
                              const Text(
                                "Commercial License Number",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              10.verticalSpace,
                              CustomTextField(
                                validator: Validators.validateMedicalLicense,
                                controller: cubit.registerNumber,
                                text: "e.g.LIC-676-78",
                              ),
                              20.verticalSpace,
                              const Text(
                                "Medical license Upload",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              10.verticalSpace,
                              const UploadMedicalLicenseCard(
                                text: "Upload your Licence",
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
                            Flexible(
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: " I agree to the Docify ",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color: ColorManager.black,
                                      ),
                                    ),
                                    TextSpan(
                                      text: " Terms of Service ",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color: ColorManager.primary,
                                        decoration: TextDecoration.underline,
                                        decorationColor: ColorManager.primary,
                                        decorationThickness: 1.5,
                                      ),
                                    ),
                                    TextSpan(
                                      text: " and ",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color: ColorManager.black,
                                      ),
                                    ),
                                    TextSpan(
                                      text: " Privacy Policy ",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color: ColorManager.primary,
                                        decoration: TextDecoration.underline,
                                        decorationColor: ColorManager.primary,
                                        decorationThickness: 1.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        25.verticalSpace,
                        CustomBtn(
                          text: "Submit for Verification",
                          onPressed: () {
                            if (!isChecked) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Please accept the terms and conditions",
                                    ),
                                  ));
                            }
                            if (_formKey.currentState!.validate() &&
                                isChecked) {
                              cubit.pharmacySignUp();
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
