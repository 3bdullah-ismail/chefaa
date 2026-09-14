import 'package:chefaa/core/imports/imports.dart';
import 'package:chefaa/core/resources/assets_manager.dart';
import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';
import 'package:chefaa/core/routes/app_routes_names.dart';
import 'package:chefaa/core/widgets/custom_btn.dart';
import 'package:chefaa/core/widgets/custom_text_field.dart';
import 'package:chefaa/core/widgets/loading.dart';
import 'package:chefaa/core/widgets/validators.dart';
import 'package:chefaa/core/widgets/custom_snackbar.dart';
import 'package:chefaa/features/auth/presentation/manager/auth_cubit.dart';
import 'package:chefaa/features/auth/presentation/widgets/custom_outline_btn.dart';
import 'package:chefaa/features/auth/presentation/widgets/not_have_account.dart';

import 'package:chefaa/core/resources/constants_manager.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController identityController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    identityController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _showSuccessAndNavigate(dynamic user) {
    CustomSnackBar.showSuccess(
      context: context,
      message: 'Welcome back ${user.name}!',
    );
    context.go(AppConstants.getLayoutFromRole(user.role!));
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
              child: BlocListener<AuthCubit, AuthState>(
                listener: (context, state) async {
                  if (state is LoginLoadingState ||
                      state is GoogleSignInLoadingState) {
                    Loading.show(context);
                  } else if (state is LoginErrorState) {
                    Loading.hide(context);
                    CustomSnackBar.showError(
                      context: context,
                      message: state.message,
                    );
                  } else if (state is GoogleSignInErrorState) {
                    Loading.hide(context);
                    CustomSnackBar.showError(
                      context: context,
                      message:
                          state.message ??
                          'An error occurred during Google sign-in',
                    );
                  } else if (state is LoginSuccessState) {
                    Loading.hide(context);
                    _showSuccessAndNavigate(state.user);
                  } else if (state is GoogleSignInSuccessState) {
                    Loading.hide(context);
                    _showSuccessAndNavigate(state.user);
                  }
                },
                child: Builder(
                  builder: (context) {
                    final loginCubit = AuthCubit.get(context);
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
                            controller: identityController,
                            text: "Enter your Email or Phone",
                            prefixIcon: IconsAssets.emailIcon,
                            validator: Validators.validateEmailOrPhone,
                          ),
                          20.verticalSpace,
                          CustomTextField(
                            controller: passwordController,
                            text: "Enter your Password",
                            prefixIcon: IconsAssets.passwordIcon,
                            validator: Validators.validateLoginPassword,
                            isPass: true,
                          ),
                          TextButton(
                            onPressed: () {
                              context.push(AppRoutesNames.forgetPassword);
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
                          45.verticalSpace,
                          CustomBtn(
                            text: "Login",
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                loginCubit.login(
                                  identity: identityController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                          ),
                          50.verticalSpace,
                          CustomOutlineBtn(
                            onPressed: () {
                              // TODO: Implement Google Sign-in
                            },
                            prefixImage: SvgAssets.google,
                            title: "Sign in with Google",
                          ),
                          20.verticalSpace,
                          NotHaveAccount(
                            onPressed: () {
                              context.pushReplacement(AppRoutesNames.option);
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
