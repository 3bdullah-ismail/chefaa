import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:chefaa/core/config/get_config.dart';
import 'package:chefaa/core/resources/assets_manager.dart';
import 'package:chefaa/core/widget/custom_btn.dart';
import 'package:chefaa/core/widget/custom_text_field.dart';
import 'package:chefaa/core/widget/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/values_manager.dart';
import '../../../../../core/routes/app_routes_names.dart';
import '../../../../../core/widget/loading.dart';
import '../../../../patient/auth/presentation/widgets/success_dialog.dart';
import '../../../google_sign_in/presentation/manager/googleSignIn_cubit.dart';
import '../../../google_sign_in/presentation/manager/googleSignIn_state.dart';
import '../manager/login_cubit.dart';
import '../manager/login_state.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<LoginCubit>()),
        BlocProvider(create: (context) => getIt<GoogleSignInCubit>()),
      ],
      child: Scaffold(
        backgroundColor: ColorManager.white,
        body: ScrollConfiguration(
          behavior: const ScrollBehavior()
              .copyWith(overscroll: false),
          child: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.p28,
                  vertical: AppPadding.p80,
                ),
                child: BlocConsumer<LoginCubit, LoginState>(
                  listener: (context, state) async {
                    if (state is LoginLoadingState) {
                      Loading.show(context);
                    } else if (state is LoginErrorState) {
                      Loading.hide(context);
                      AnimatedSnackBar.rectangle(
                        'Error',
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
                            Future.microtask(() async {
                              await Future.delayed(const Duration(milliseconds: 1500));
                              if (mounted) {
                                Navigator.of(context).pop();
                                _navigationService.toLayout(state.user.role!);
                              }
                            });

                            return SuccessDialog(
                              title: "Yeah ! Welcome back ${state.user.name}",
                              content:
                              "Once again you login successfully into Chefaa app",
                            );
                          },
                        );
                      });
                    }
                  },
                  builder: (context, state) {
                    final loginCubit = LoginCubit.get(context);
                    final googleSignInCubit = GoogleSignInCubit.get(context);

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
                          CustomTextField(
                            controller: loginCubit.identityController,
                            text: "Enter your Email or Phone",
                            prefixIcon: IconsAssets.emailIcon,
                            validator: Validators.validateEmailOrPhone,
                          ),
                          20.verticalSpace,
                          CustomTextField(
                            controller: loginCubit.passwordController,
                            text: "Enter your Password",
                            prefixIcon: IconsAssets.passwordIcon,
                            isPass: true,
                            validator: Validators.validatePassword,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutesNames.forgetPassword,
                              );
                            },
                            child: const Text(
                              "Forgot Password?",
                              style: TextStyle(
                                color: ColorManager.primary,
                                fontSize: 16,
                                decoration: TextDecoration.underline,
                                decorationColor: ColorManager.primary,
                              ),
                            ),
                          ),
                          50.verticalSpace,
                          CustomBtn(
                            text: "Login",
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                loginCubit.login();
                              }
                            },
                          ),
                          50.verticalSpace,
                          BlocConsumer<GoogleSignInCubit, GoogleSignInState>(
                            listener: (context, state) {
                              if (state is GoogleSignInLoadingState) {
                                Loading.show(context);
                              } else if (state is GoogleSignInErrorState) {
                                Loading.hide(context);
                                AnimatedSnackBar.rectangle(
                                  'Error',
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
                                      Future.microtask(() async {
                                        await Future.delayed(
                                            const Duration(milliseconds: 1500));
                                        if (mounted) {
                                          Navigator.of(context).pop();
                                          _navigationService
                                              .toLayout(state.user.role!);
                                        }
                                      });

                                      return SuccessDialog(
                                        title: "Yeah ! Welcome back ${state.user.name}",
                                        content:
                                        "Once again you login successfully into Chefaa app",
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
                                    final result = await GoogleSignIn.instance.authenticate();
                                    final String? idToken = result.authentication.idToken;

                                    if (idToken != null) {
                                      googleSignInCubit.signInWithGoogle(idToken);
                                    } else {
                                      AnimatedSnackBar.rectangle(
                                        'Error',
                                        'Failed to retrieve Google ID token.',
                                        type: AnimatedSnackBarType.error,
                                        brightness: Brightness.dark,
                                        duration: const Duration(seconds: 3),
                                      ).show(context);
                                    }
                                  } catch (e) {
                                    if (e is! Exception || !e.toString().contains('cancel')) {
                                      AnimatedSnackBar.rectangle(
                                        'Error',
                                        e.toString(),
                                        type: AnimatedSnackBarType.error,
                                        brightness: Brightness.dark,
                                        duration: const Duration(seconds: 3),
                                      ).show(context);
                                    }
                                  }
                                },
                                prefixImage: SvgAssets.google,
                                title: "Sign in with Google",
                              );
                            },
                          ),
                          30.verticalSpace,
                          NotHaveAccount(
                            onPressed: () {
                              _navigationService.toSignUp(widget.role);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}