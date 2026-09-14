import 'package:chefaa/core/config/get_config.dart';
import 'package:chefaa/core/imports/imports.dart';
import 'package:chefaa/core/resources/assets_manager.dart';
import 'package:chefaa/core/resources/constants_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';
import 'package:chefaa/core/routes/app_routes_names.dart';
import 'package:chefaa/core/widgets/already_have_account.dart';
import 'package:chefaa/core/widgets/custom_app_bar.dart';
import 'package:chefaa/core/widgets/custom_btn.dart';
import 'package:chefaa/core/widgets/custom_snackbar.dart';
import 'package:chefaa/core/widgets/custom_text_field.dart';
import 'package:chefaa/core/widgets/loading.dart';
import 'package:chefaa/core/widgets/terms_of_service.dart';
import 'package:chefaa/features/patient/auth/presentation/manager/patient_auth_cubit.dart';
import 'package:chefaa/features/patient/auth/presentation/manager/patient_auth_state.dart';

import '../../../../../core/widgets/app_bar_content.dart';
import '../../../../../core/widgets/validators.dart';

class PatientSignUpPage extends StatefulWidget {
  const PatientSignUpPage({super.key});

  @override
  State<PatientSignUpPage> createState() => _PatientSignUpPageState();
}

class _PatientSignUpPageState extends State<PatientSignUpPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isChecked = false;
  late final PatientAuthCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<PatientAuthCubit>();
  }

  @override
  void dispose() {
    nameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: CustomAppBar(
          preferredHeight: 150.h,
          padding: REdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
          child: const AppBarContent(),
        ),
        body: BlocListener<PatientAuthCubit, PatientAuthState>(
          listener: (context, state) {
            if (state is SignUpLoadingState) {
              Loading.show(context);
            } else if (state is SignUpErrorState) {
              Loading.hide(context);

              CustomSnackBar.showError(
                context: context,
                message: state.message,
              );
            } else if (state is SignUpSuccessState) {
              Loading.hide(context);
              CustomSnackBar.showSuccess(
                context: context,
                message: "Account created successfully",
              );
              context.go(AppRoutesNames.patientSignUpCompleteData);
            }
          },
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: REdgeInsets.symmetric(
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
                              controller: nameController,
                              text: AppConstants.firstName,
                              prefixIcon: IconsAssets.userIcon,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.name,
                            ),
                          ),
                          Expanded(
                            child: CustomTextField(
                              validator: Validators.nameValidator,
                              controller: lastNameController,
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
                        controller: phoneController,
                        text: AppConstants.enterPhone,
                        prefixIcon: IconsAssets.phoneIcon,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.phone,
                      ),
                      15.verticalSpace,
                      CustomTextField(
                        validator: Validators.validateEmail,
                        controller: emailController,
                        text: AppConstants.enterEmail,
                        prefixIcon: IconsAssets.emailIcon,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      15.verticalSpace,
                      CustomTextField(
                        validator: Validators.validatePassword,
                        controller: passwordController,
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
                              passwordController.text,
                            ),
                        controller: confirmPasswordController,
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
                      BlocSelector<PatientAuthCubit, PatientAuthState, bool>(
                        selector: (state) => state is SignUpLoadingState,
                        builder: (context, isLoading) {
                          return CustomBtn(
                            isDisabled: isLoading || !isChecked,
                            text: AppConstants.createAccount,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _cubit.patientSignUp(
                                  firstName: nameController.text,
                                  lastName: lastNameController.text,
                                  phone: phoneController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                          );
                        },
                      ),
                      12.verticalSpace,
                      AlreadyHaveAccount(
                        onPressed: () {
                          context.go(AppRoutesNames.login);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
