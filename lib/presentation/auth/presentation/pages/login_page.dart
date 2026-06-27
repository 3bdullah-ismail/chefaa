import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:chefaa/core/resources/assets_manager.dart';
import 'package:chefaa/core/widget/custom_btn.dart';
import 'package:chefaa/core/widget/custom_text_field.dart';
import 'package:chefaa/core/widget/validators.dart';
import 'package:chefaa/presentation/auth/presentation/manager/auth_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../../core/routes/app_routes_names.dart';
import '../../../../core/widget/loading.dart';
import '../../../patient/auth/presentation/widgets/language_switch.dart';
import '../../../patient/auth/presentation/widgets/success_dialog.dart';
import '../widgets/custom_outline_btn.dart';
import '../widgets/not_have_account.dart';
import '../widgets/role_based_nav.dart';

class LoginPage extends StatefulWidget {
  final String? role;

  const LoginPage({super.key, this.role});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late RoleNavigationService _navigationService;

  @override
  void initState() {
    super.initState();
    _navigationService = RoleNavigationService(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.p28,
                vertical: AppPadding.p80,
              ),
              child: BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) async {
                  if (state is LoginLoadingState) {
                    Loading.show(context);
                  } else if (state is LoginErrorState) {
                    Loading.hide(context);
                    AnimatedSnackBar.rectangle(
                      'error'.tr(),
                      state.message,
                      type: AnimatedSnackBarType.error,
                      brightness: Brightness.dark,
                      duration: const Duration(seconds: 3),
                    ).show(context);
                  } else if (state is LoginSuccessState) {
                    Loading.hide(context);

                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          final navigator = Navigator.of(context);
                          Future.microtask(() async {
                            await Future.delayed(
                              const Duration(milliseconds: 1500),
                            );
                            if (mounted) {
                              navigator.pop();
                              _navigationService.toLayout(state.user.role!);
                            }
                          });

                          return SuccessDialog(
                            title: "welcomeBack ${state.user.name}".tr(),
                            content:
                                "loginSuccess".tr(),
                          );
                        },
                      );
                    });
                  }
                },
                builder: (context, state) {
                  final loginCubit = AuthCubit.get(context);
                  final googleSignInCubit = AuthCubit.get(context);

                  return Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Center(
                          child: Image.asset(
                            ImageAssets.loginLogo,
                            fit: BoxFit.fill,
                            width: double.infinity,
                          ),
                        ),
                        70.verticalSpace,
                        CustomTextField(
                          controller: loginCubit.identityController,
                          text: "emailOrPhone".tr(),
                          prefixIcon: IconsAssets.emailIcon,
                          validator: Validators.validateEmailOrPhone,
                        ),
                        20.verticalSpace,
                        CustomTextField(
                          controller: loginCubit.passwordController,
                          text: "password".tr(),
                          prefixIcon: IconsAssets.passwordIcon,
                          isPass: true,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutesNames.forgetPassword,
                            );
                          },
                          child: Text(
                            "forgotPassword".tr(),
                            style: const TextStyle(
                              color: ColorManager.primary,
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                              decorationColor: ColorManager.primary,
                            ),
                          ),
                        ),
                        45.verticalSpace,
                        CustomBtn(
                          text: "login".tr(),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              loginCubit.login();
                            }
                          },
                        ),
                        50.verticalSpace,
                        BlocConsumer<AuthCubit, AuthState>(
                          listener: (context, state) {
                            if (state is GoogleSignInLoadingState) {
                              Loading.show(context);
                            } else if (state is GoogleSignInErrorState) {
                              Loading.hide(context);
                              AnimatedSnackBar.rectangle(
                                'error'.tr(),
                                state.message!,
                                type: AnimatedSnackBarType.error,
                                brightness: Brightness.dark,
                                duration: const Duration(seconds: 3),
                              ).show(context);
                            } else if (state is GoogleSignInSuccessState) {
                              Loading.hide(context);

                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) {
                                    final navigator = Navigator.of(context);
                                    Future.microtask(() async {
                                      await Future.delayed(
                                        const Duration(milliseconds: 1500),
                                      );
                                      if (mounted) {
                                        navigator.pop();
                                        _navigationService.toLayout(
                                          state.user.role!,
                                        );
                                      }
                                    });

                                    return SuccessDialog(
                                      title:
                                          "welcomeBack ${state.user.name}".tr(),
                                      content:
                                          "loginSuccess".tr(),
                                    );
                                  },
                                );
                              });
                            }
                          },
                          builder: (context, state) {
                            return CustomOutlineBtn(
                              onPressed: () async {
                                try {
                                  final result = await GoogleSignIn.instance
                                      .authenticate();
                                  final String? idToken =
                                      result.authentication.idToken;

                                  if (idToken != null) {
                                    googleSignInCubit.signInWithGoogle(idToken);
                                  } else if (mounted) {
                                    AnimatedSnackBar.rectangle(
                                      'error'.tr(),
                                      'Failed to retrieve Google ID token.'.tr(),
                                      type: AnimatedSnackBarType.error,
                                      brightness: Brightness.dark,
                                      duration: const Duration(seconds: 3),
                                    ).show(this.context);
                                  }
                                } catch (e) {
                                  if (mounted &&
                                      (e is! Exception ||
                                          !e.toString().contains('cancel'))) {
                                    AnimatedSnackBar.rectangle(
                                      'Error'.tr(),
                                      e.toString(),
                                      type: AnimatedSnackBarType.error,
                                      brightness: Brightness.dark,
                                      duration: const Duration(seconds: 3),
                                    ).show(this.context);
                                  }
                                }
                              },
                              prefixImage: SvgAssets.google,
                              title: "signInGoogle".tr(),
                            );
                          },
                        ),
                        20.verticalSpace,
                        NotHaveAccount(
                          onPressed: () {
                            _navigationService.toSignUp(widget.role);
                          },
                        ),
                        15.verticalSpace,
                        const LanguageSwitch(),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
