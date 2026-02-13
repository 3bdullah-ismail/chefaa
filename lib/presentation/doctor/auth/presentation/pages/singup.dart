import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:chefaa/core/config/get_config.dart';
import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/widget/custom_app_bar.dart';
import 'package:chefaa/core/widget/custom_btn.dart';
import 'package:chefaa/core/widget/custom_text_btn.dart';
import 'package:chefaa/core/widget/custom_text_field.dart';
import 'package:chefaa/core/widget/validators.dart';
import 'package:chefaa/presentation/doctor/auth/presentation/manager/doctor_auth_cubit.dart';
import 'package:chefaa/core/widget/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/manager/file_handler_cubit.dart';
import '../../../../../core/resources/assets_manager.dart';
import '../../../../../core/widget/already_have_account.dart';
import '../../../../../core/widget/terms_of_service.dart';
import '../../../../../core/widget/upload_container.dart';

class DocSignUp extends StatefulWidget {
  const DocSignUp({super.key});

  @override
  State<DocSignUp> createState() => _DocSignUpState();
}

class _DocSignUpState extends State<DocSignUp> {
  bool isChecked = false;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DoctorAuthCubit>(),
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(175),
          child: CustomAppBar(),
        ),
        body: BlocConsumer<DoctorAuthCubit, DoctorAuthState>(
          listener: (context, state) {
            if (state is SingUpLoading) {
              showDialog(
                context: context,
                builder: (context) => const LoadingDialog(),
              );
            } else if (state is SingUpFailure) {
              AnimatedSnackBar.rectangle(
                'Error',
                state.errorMessage,
                type: AnimatedSnackBarType.error,
                brightness: Brightness.dark,
              ).show(context);
            } else if (state is SingUpSuccess) {
              AnimatedSnackBar.rectangle(
                'Success',
                "Welcome Dr. ${state.userName}!",
                type: AnimatedSnackBarType.success,
                brightness: Brightness.dark,
              ).show(context);
            } else {}
          },
          builder: (context, state) {
            var cubit = DoctorAuthCubit.get(context);
            return SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(height: 45.h),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                validator: Validators.nameValidator,
                                controller: cubit.name,
                                text: "First Name",
                                prefixIcon:
                                    "assets/icons/User_icon_Inactive.svg",
                              ),
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: CustomTextField(
                                validator: Validators.validateUsername,
                                controller: cubit.username,
                                text: "last Name",
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        CustomTextField(
                          validator: Validators.validatePhone,
                          controller: cubit.phoneNumber,
                          text: "Enter your phone number",
                          prefixIcon: "assets/icons/call.svg",
                        ),
                        SizedBox(height: 8.h),
                        CustomTextField(
                          validator: Validators.validateEmail,
                          controller: cubit.email,
                          text: "Enter your email",
                          prefixIcon: "assets/icons/Email.svg",
                        ),
                        SizedBox(height: 8.h),
                        CustomTextField(
                          validator: Validators.validatePassword,
                          controller: cubit.password,
                          text: "Enter your password",
                          prefixIcon: "assets/icons/Password.svg",

                          isPass: true,
                        ),
                        SizedBox(height: 8.h),
                        CustomTextField(
                          validator: (value) =>
                              Validators.validateConfirmPassword(
                                value,
                                cubit.password.text,
                              ),
                          controller: cubit.confirmPasswordController,
                          text: "Re-enter your password",
                          prefixIcon: "assets/icons/Password.svg",

                          isPass: true,
                        ),
                        SizedBox(height: 8.h),
                        CustomTextField(
                          controller: cubit.specialization,
                          text: "Enter your specialization",
                          prefixIcon: "assets/icons/stethoscnnnnope_.svg",
                        ),
                        SizedBox(height: 8.h),
                        const UploadCard(),
                        SizedBox(height: 16.h),

                        Row(
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
                            Expanded(child: TermsOfService()),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        CustomBtn(
                          isDisabled:
                              !isChecked || !_formKey.currentState!.validate(),
                          text: "Submit for Verification",
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              final file = context
                                  .read<FileHandlerCubit>()
                                  .pickedFile;

                              cubit.signUp(membershipFile: file);
                            }
                          },
                        ),
                        AlreadyHaveAccount(),
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
