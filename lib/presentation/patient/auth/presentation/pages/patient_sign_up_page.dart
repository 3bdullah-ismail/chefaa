import 'package:chefaa/core/resources/assets_manager.dart';
import 'package:chefaa/core/resources/constants_manager.dart';
import 'package:chefaa/core/widget/already_have_account.dart';
import 'package:chefaa/core/widget/custom_btn.dart';
import 'package:chefaa/core/widget/loading.dart';
import 'package:chefaa/core/widget/terms_of_service.dart';
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
import '../../../complete_auth_data/presentation/manager/complete_cubit.dart';
import '../../../complete_auth_data/presentation/pages/first_complete_page.dart';
import '../manager/patient_state.dart';
import '../widgets/success_dialog.dart';

class PatientSignUpPage extends StatefulWidget {
  final String? role;

  const PatientSignUpPage({super.key, required this.role});

  @override
  State<PatientSignUpPage> createState() => _PatientSignUpPageState();
}

class _PatientSignUpPageState extends State<PatientSignUpPage> {
  final _formKey = GlobalKey<FormState>();
  bool isChecked = false;
  late final PatientCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<PatientCubit>()..setRole(widget.role!);
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
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
              showDialog(
                context: context,
                builder: (context) => const SuccessDialog(
                  title: "Success",
                  content: "Account created successfully",
                ),
                barrierDismissible: false,
              );
              Future.delayed(const Duration(seconds: 2), () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider(
                      create: (_) => getIt<CompleteCubit>(),
                      child: const FirstCompletePage(),
                    ),
                  ),
                );
              });
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
                                text: AppConstants.firstName,
                                prefixIcon: IconsAssets.userIcon,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.name,
                              ),
                            ),
                            Expanded(
                              child: CustomTextField(
                                validator: Validators.validateUsername,
                                controller: cubit.userNameController,
                                text: AppConstants.lastName,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.name,
                              ),
                            ),
                          ],
                        ),
                        15.verticalSpace,
                        CustomTextField(
                          validator: Validators.validatePhone,
                          controller: cubit.phoneController,
                          text: AppConstants.enterPhone,
                          prefixIcon: IconsAssets.phoneIcon,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.phone,
                        ),

                        15.verticalSpace,
                        CustomTextField(
                          validator: Validators.validateEmail,
                          controller: cubit.emailController,
                          text: AppConstants.enterEmail,
                          prefixIcon: IconsAssets.emailIcon,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        15.verticalSpace,
                        CustomTextField(
                          validator: Validators.validatePassword,
                          controller: cubit.passwordController,
                          text: AppConstants.enterPassword,
                          prefixIcon: IconsAssets.passwordIcon,
                          isPass: true,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.visiblePassword,
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
                          prefixIcon: IconsAssets.passwordIcon,
                          isPass: true,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.visiblePassword,
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
                        50.verticalSpace,
                        CustomBtn(
                          isDisabled:
                              state is SignUpLoadingState || !isChecked,
                          text: AppConstants.createAccount,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              cubit.patientSignUp();
                            }
                          },
                        ),
                        12.verticalSpace,
                        AlreadyHaveAccount(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              AppRoutesNames.login,
                            );
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
