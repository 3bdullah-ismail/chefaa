import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:chefaa/features/auth/data/models/auth_response.dart';
import 'package:chefaa/core/services/storage_service.dart';
import 'package:chefaa/features/patient/home/presentation/manager/users_cubit.dart';
import 'package:chefaa/features/auth/domain/repositories/repo.dart';

part 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final AuthRepo repo;
  final UsersCubit usersCubit;

  AuthCubit({required this.repo, required this.usersCubit})
    : super(AuthInitial());

  AuthCubit.initial({required this.repo, required this.usersCubit})
    : super(AuthInitial());
  TextEditingController identityController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> forgotPassFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> resetPassFormKey = GlobalKey<FormState>();

  List<TextEditingController?> otpControllers = [];
  bool _isSubmitting = false;

  String _identity = '';
  String _verifiedCode = '';

  static AuthCubit get(BuildContext context) => BlocProvider.of(context);

  void setOtpControllers(List<TextEditingController?> controllers) {
    otpControllers = controllers;
  }

  String _getIdentity(int index) =>
      index == 0 ? emailController.text.trim() : phoneController.text.trim();

  Future<void> login() async {
    if (_isSubmitting) return;
    _isSubmitting = true;
      if (!isClosed) emit(LoginLoadingState());
    try {
      final res = await repo.login(
        identity: identityController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (res.accessToken != null) {
        await StorageService.saveToken(res.accessToken!);
      }
      if (res.user != null) {
        await StorageService.saveUser(res.user!);
        if (res.user!.role != null) {
          await StorageService.saveRole(res.user!.role!);
        }
      }
      await usersCubit.setUser(res);
      _clearLoginControllers();
      if (!isClosed) {
        emit(
        LoginSuccessState(
          user: res.user!,
          message: res.message ?? 'Login successful',
        ),
      );
      }
    } catch (e) {
      if (!isClosed) emit(LoginErrorState(e.toString()));
    } finally {
      _isSubmitting = false;
    }
  }

  Future<void> signInWithGoogle(String idToken) async {
    if (_isSubmitting) return;
    _isSubmitting = true;
      if (!isClosed) emit(GoogleSignInLoadingState());

    try {
      final res = await repo.googleSignIn(idToken);

      if (res.accessToken != null) {
        await StorageService.saveToken(res.accessToken!);
      }
      if (res.user != null) {
        await StorageService.saveUser(res.user!);
        if (res.user!.role != null) {
          await StorageService.saveRole(res.user!.role!);
        }
      }
      await usersCubit.setUser(res);
      _clearLoginControllers();
      if (!isClosed) {
        emit(
        GoogleSignInSuccessState(
          user: res.user!,
          message: res.message ?? "Login successful",
        ),
      );
      }
    } catch (e) {
      if (!isClosed) emit(GoogleSignInErrorState(e.toString()));
    } finally {
      _isSubmitting = false;
    }
  }

  Future<void> forgotPass(int index) async {
    if (!forgotPassFormKey.currentState!.validate()) return;

    _identity = _getIdentity(index);
      if (!isClosed) emit(ForgotPassLoadingState());

    try {
      final response = await repo.forgotPass(identity: _identity);
      if (!isClosed) emit(ForgotPassSuccessState(message: response.message));
    } catch (e) {
      if (!isClosed) emit(ForgotPassErrorState(message: e.toString()));
    }
  }

  Future<void> resetCode(int index) async {
    final code = otpControllers.map((e) => e?.text ?? '').join();

    if (code.length < 4) {
      if (!isClosed) emit(ResetCodeErrorState(message: "Please enter the full 4-digit code."));
      return;
    }

    _identity = _getIdentity(index);
      if (!isClosed) emit(ResetCodeLoadingState());

    try {
      final response = await repo.resetCode(code: code, identity: _identity);
      _verifiedCode = code;
      _clearOtpControllers();
      if (!isClosed) emit(ResetCodeSuccessState(message: response.message));
    } catch (e) {
      if (!isClosed) emit(ResetCodeErrorState(message: e.toString()));
    }
  }

  Future<void> resetPass() async {
    if (!resetPassFormKey.currentState!.validate()) return;
      if (!isClosed) emit(ResetPassLoadingState());

    try {
      await repo.resetPass(
        identity: _identity,
        code: _verifiedCode,
        newPassword: password.text,
      );
      _clearPasswordControllers();
      _verifiedCode = '';
      if (!isClosed) emit(ResetPassSuccessState());
    } catch (e) {
      if (!isClosed) emit(ResetPassErrorState(message: e.toString()));
    }
  }

  void _clearOtpControllers() {
    for (final controller in otpControllers) {
      controller?.clear();
    }
  }

  void _clearPasswordControllers() {
    password.clear();
    confirmPasswordController.clear();
  }

  void _clearLoginControllers() {
    identityController.clear();
    passwordController.clear();
  }

  @override
  Future<void> close() {
    identityController.dispose();
    passwordController.dispose();
    emailController.dispose();
    phoneController.dispose();
    password.dispose();
    confirmPasswordController.dispose();
    for (var controller in otpControllers) {
      controller?.dispose();
    }
    return super.close();
  }
}
