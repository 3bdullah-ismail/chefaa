import 'package:chefaa/core/resources/assets_manager.dart';
import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/widget/custom_btn.dart';
import 'package:chefaa/core/widget/loading.dart';
import 'package:chefaa/presentation/patient/auth/presentation/manager/patient_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/config/get_config.dart';
import '../../../../../core/resources/values_manager.dart';
import '../../../../../core/routes/app_routes_names.dart';
import '../../../../../core/widget/custom_app_bar.dart';
import '../../../../../core/widget/custom_text_field.dart';
import '../../../../../core/widget/validators.dart';
import '../manager/patient_state.dart';

class PatientSignUpPage extends StatefulWidget {
  final String? role;

  PatientSignUpPage({super.key, required this.role});

  @override
  State<PatientSignUpPage> createState() => _PatientSignUpPageState();
}

class _PatientSignUpPageState extends State<PatientSignUpPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<PatientCubit>()..setRole(widget.role!),

      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(175),
          child: CustomAppBar(),
        ),
        body: BlocConsumer<PatientCubit, PatientState>(
          listener: (context, state) {
            if (state is SignUpLoadingState) {
              Loading.show(context);
            }
            if (state is SignUpErrorState) {
              Loading.hide(context);
            }
            if (state is SignUpSuccessState) {
              Loading.hide(context);
              Navigator.pushReplacementNamed(
                context,
                AppRoutesNames.patientSignUpComplete,
              );
            }
          },
          builder: (context, state) {
            final cubit = PatientCubit.get(context);

            return SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p28,
                    vertical: AppPadding.p48,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Row(
                          spacing: 7,
                          children: [
                            Expanded(
                              child: CustomTextField(
                                validator: Validators.nameValidator,
                                controller: cubit.nameController,
                                text: " First Name",
                                prefixIcon: IconsAssets.userIconInactive,
                              ),
                            ),
                            Expanded(
                              child: CustomTextField(
                                validator: Validators.nameValidator,
                                controller: cubit.userNameController,
                                text: "Last Name",
                              ),
                            ),
                          ],
                        ),
                        15.verticalSpace,
                        CustomTextField(
                          validator: Validators.validatePhone,
                          controller: cubit.phoneController,
                          text: " Enter your Phone Number ",
                          prefixIcon: IconsAssets.phoneIconInactive,
                        ),

                        15.verticalSpace,
                        CustomTextField(
                          validator: Validators.validateEmail,
                          controller: cubit.emailController,
                          text: " Enter your Email",
                          prefixIcon: IconsAssets.emailIconInactive,
                        ),
                        15.verticalSpace,
                        CustomTextField(
                          validator: Validators.validatePassword,
                          controller: cubit.passwordController,
                          text: " Enter your Password",
                          prefixIcon: IconsAssets.passwordIconInactive,
                          isPass: true,
                        ),
                        15.verticalSpace,
                        CustomTextField(
                          validator: (value) =>
                              Validators.validateConfirmPassword(
                                value,
                                cubit.passwordController.text,
                              ),
                          controller: cubit.confirmPasswordController,
                          text: " Confirm your Password",
                          prefixIcon: IconsAssets.passwordIconInactive,
                          isPass: true,
                        ),
                        27.verticalSpace,
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
                                   isChecked =!isChecked;
                                 });
                                },
                                icon:
                                isChecked
                                    ?SvgPicture.asset(
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
                                        fontSize: 13.sp,
                                        color: ColorManager.black,
                                      ),
                                    ),
                                    TextSpan(
                                      text: " Terms of Service ",
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        color: ColorManager.primary,
                                        decoration: TextDecoration.underline,
                                        decorationColor: ColorManager.primary,
                                        decorationThickness: 1.5,
                                      ),
                                    ),
                                    TextSpan(
                                      text: " and ",
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        color: ColorManager.black,
                                      ),
                                    ),
                                    TextSpan(
                                      text: " Privacy Policy ",
                                      style: TextStyle(
                                        fontSize: 13.sp,
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
                        50.verticalSpace,
                        CustomBtn(
                          text: "Create Account",
                          onPressed: () {
                            if (!isChecked) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Please accept the terms and conditions",
                                  ),
                              ));
                            }
                            if (_formKey.currentState!.validate() && isChecked) {
                              cubit.patientSignUp();
                            }
                          },
                        ),
                        12.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Do you already have an account?",
                              style: TextStyle(
                                color: ColorManager.gray,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.padded,
                              ),
                              onPressed: () {},
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                  color: ColorManager.primary,
                                  decoration: TextDecoration.underline,
                                  decorationColor: ColorManager.primary,
                                  decorationThickness: 1.5,
                                ),
                              ),
                            ),
                          ],
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
