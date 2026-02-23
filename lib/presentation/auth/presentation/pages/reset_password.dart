import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/styles_manager.dart';
import '../../../../core/routes/app_routes_names.dart';
import '../../../../core/widget/custom_app_bar.dart';
import '../../../../core/widget/custom_btn.dart';
import '../../../../core/widget/custom_text_field.dart';
import '../../../../core/widget/loading.dart';
import '../../../../core/widget/validators.dart';
import '../manager/auth_cubit.dart';
import '../widgets/back_button.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: ColorManager.white,
        title: Center(child: Text(message)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(175),
        child: CustomAppBar(),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is ResetPassLoadingState) {
            Loading.show(context);
          } else if (state is ResetPassSuccessState) {
            Loading.hide(context);
            // Navigator.pushNamedAndRemoveUntil(
            //   context,
            //   AppRoutesNames.signin,
            //       (route) => false,
            // );
          } else if (state is ResetPassErrorState) {
            Loading.hide(context);
            _showErrorDialog(
              context,
              state.message?.toString() ??
                  "An error occurred. Please try again.",
            );
          }
        },
        builder: (context, state) {
          final cubit = AuthCubit.get(context);
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: cubit.resetPassFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BackBtn(),
                  36.verticalSpace,
                  Text(
                    "Create New Password",
                    style: getBoldStyle(
                      color: ColorManager.black,
                      fontSize: FontSize.s24,
                    ),
                  ),
                  16.verticalSpace,
                  Text(
                    "Create your new password to login",
                    style: getMediumStyle(
                      color: ColorManager.gray,
                      fontSize: 16,
                    ),
                  ),
                  62.verticalSpace,
                  CustomTextField(
                    validator: Validators.validatePassword,
                    controller: cubit.password,
                    text: "Enter your new password",
                    prefixIcon: IconsAssets.passwordIcon,
                    isPass: true,
                  ),
                  8.verticalSpace,
                  CustomTextField(
                    validator: (value) => Validators.validateConfirmPassword(
                      value,
                      cubit.password.text,
                    ),
                    controller: cubit.confirmPasswordController,
                    text: "Confirm password",
                    prefixIcon: IconsAssets.passwordIcon,
                    isPass: true,
                  ),
                  56.verticalSpace,
                  CustomBtn(
                    text: "Reset Password",
                    onPressed: () => cubit.resetPass(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
