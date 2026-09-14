import 'package:chefaa/core/config/get_config.dart';
import 'package:chefaa/core/imports/imports.dart';
import 'package:chefaa/core/resources/assets_manager.dart';
import 'package:chefaa/core/resources/constants_manager.dart';
import 'package:chefaa/core/routes/app_routes_names.dart';
import 'package:chefaa/core/widgets/already_have_account.dart';
import 'package:chefaa/core/widgets/app_bar_content.dart';
import 'package:chefaa/core/widgets/custom_app_bar.dart';
import 'package:chefaa/core/widgets/custom_btn.dart';
import 'package:chefaa/core/widgets/custom_snackbar.dart';
import 'package:chefaa/core/widgets/custom_text_field.dart';
import 'package:chefaa/core/widgets/loading.dart';
import 'package:chefaa/core/widgets/terms_of_service.dart';
import 'package:chefaa/core/widgets/upload_container.dart';
import 'package:chefaa/core/widgets/validators.dart';
import 'package:chefaa/features/doctor/auth/presentation/manager/doctor_auth_cubit.dart';

import '../../../../../core/file_handler/file_handler_cubit.dart';

class DocSignUp extends StatefulWidget {
  const DocSignUp({super.key});

  @override
  State<DocSignUp> createState() => _DocSignUpState();
}

class _DocSignUpState extends State<DocSignUp> {
  bool isChecked = false;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController specializationController =
      TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  late final DoctorAuthCubit _cubit;
  late final FileHandlerCubit _fileHandlerCubit;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<DoctorAuthCubit>();
    _fileHandlerCubit = context.read<FileHandlerCubit>();
    _fileHandlerCubit.clearFile();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    specializationController.dispose();
    confirmPasswordController.dispose();

    _cubit.close();
    _fileHandlerCubit.clearFile();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        appBar: CustomAppBar(
          preferredHeight: 150.h,
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
          child: const AppBarContent(),
        ),
        body: BlocListener<DoctorAuthCubit, DoctorAuthState>(
          listener: (context, state) {
            if (state is SingUpLoading) {
              Loading.show(context);
            } else if (state is SingUpFailure) {
              Loading.hide(context);
              CustomSnackBar.showError(
                context: context,
                message: state.errorMessage,
              );
            } else if (state is SingUpSuccess) {
              Loading.hide(context);
              CustomSnackBar.showSuccess(
                context: context,
                message: "Welcome Dr. ${state.userName}!",
              );
              context.go(AppRoutesNames.login);
            }
          },
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      45.verticalSpace,
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              validator: Validators.nameValidator,
                              controller: firstNameController,
                              text: AppConstants.firstName,
                              prefixIcon: IconsAssets.userIcon,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.name,
                            ),
                          ),
                          8.horizontalSpace,
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
                      8.verticalSpace,
                      CustomTextField(
                        validator: Validators.validatePhone,
                        controller: phoneController,
                        text: AppConstants.enterPhone,
                        prefixIcon: IconsAssets.phoneIcon,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.phone,
                      ),
                      8.verticalSpace,
                      CustomTextField(
                        validator: Validators.validateEmail,
                        controller: emailController,
                        text: AppConstants.enterEmail,
                        prefixIcon: IconsAssets.emailIcon,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      8.verticalSpace,
                      CustomTextField(
                        validator: Validators.validatePassword,
                        controller: passwordController,
                        text: AppConstants.enterPassword,
                        prefixIcon: IconsAssets.passwordIcon,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.visiblePassword,
                        isPass: true,
                      ),
                      8.verticalSpace,
                      CustomTextField(
                        textInputAction: TextInputAction.next,
                        validator: (value) =>
                            Validators.validateConfirmPassword(
                              value,
                              passwordController.text,
                            ),
                        controller: confirmPasswordController,
                        text: AppConstants.reEnterPassword,
                        prefixIcon: IconsAssets.passwordIcon,
                        keyboardType: TextInputType.visiblePassword,
                        isPass: true,
                      ),
                      8.verticalSpace,
                      CustomTextField(
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.text,
                        controller: specializationController,
                        text: "Enter your specialization",
                        prefixIcon: IconsAssets.drugIcon,
                      ),
                      8.verticalSpace,
                      const UploadCard(),
                      16.verticalSpace,
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
                          12.horizontalSpace,
                          const Expanded(child: TermsOfService()),
                        ],
                      ),
                      16.verticalSpace,
                      BlocSelector<DoctorAuthCubit, DoctorAuthState, bool>(
                        selector: (state) => state is SingUpLoading,
                        builder: (context, isLoading) {
                          return CustomBtn(
                            isDisabled: !isChecked || isLoading,
                            text: AppConstants.submitForVerification,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                final file = context
                                    .read<FileHandlerCubit>()
                                    .pickedFile;

                                if (file == null) {
                                  CustomSnackBar.showError(
                                    context: context,
                                    message:
                                        "Please upload your membership file",
                                  );
                                  return;
                                }

                                _cubit.signUp(
                                  membershipFile: file,
                                  name: firstNameController.text,
                                  lastName: lastNameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phoneNumber: phoneController.text,
                                  specialization: specializationController.text,
                                );
                              }
                            },
                          );
                        },
                      ),
                      AlreadyHaveAccount(
                        onPressed: () {
                          context.go(
                            AppRoutesNames.login,
                            extra: AppConstants.doctor.toLowerCase(),
                          );
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
