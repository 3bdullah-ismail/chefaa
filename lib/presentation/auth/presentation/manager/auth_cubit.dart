import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/models/auth_response.dart';
import '../../../../core/services/storage_service.dart';
import '../../../patient/layout/home/presentation/manager/users_cubit.dart';
import '../../data/repositories/repo.dart';

part 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final AuthRepo repo;
  final UsersCubit usersCubit;

  AuthCubit({required this.repo, required this.usersCubit})
      : super(AuthInitial());

  AuthCubit.initial({required this.repo, required this.usersCubit}) : super(AuthInitial());
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

  String _identity = '';
  String _verifiedCode = '';

  static AuthCubit get(BuildContext context) => BlocProvider.of(context);

  void setOtpControllers(List<TextEditingController?> controllers) {
    otpControllers = controllers;
  }

  String _getIdentity(int index) =>
      index == 0 ? emailController.text.trim() : phoneController.text.trim();

  Future<void> login() async {
    emit(LoginLoadingState());
    try {
      final res = await repo.login(
        identity: identityController.text.trim(),
        password: passwordController.text.trim(),
      );

      await StorageService.saveToken(res.accessToken!);
      await StorageService.saveUser(res.user!);
      await StorageService.saveRole(res.user!.role!);
      await usersCubit.setUser(res);


      emit(
        LoginSuccessState(
          user: res.user!,
          message: res.message ?? 'Login successful',
        ),
      );
    } catch (e) {
      emit(LoginErrorState(e.toString()));
    }
  }

  Future<void> signInWithGoogle(String idToken) async {
    emit(GoogleSignInLoadingState());

    try {
      final res = await repo.googleSignIn(idToken);

      await StorageService.saveToken(res.accessToken!);
      await StorageService.saveUser(res.user!);
      await StorageService.saveRole(res.user!.role!);
      await usersCubit.setUser(res);

      emit(
        GoogleSignInSuccessState(
          user: res.user!,
          message: res.message ?? "Login successful",
        ),
      );
    } catch (e) {
      emit(GoogleSignInErrorState(e.toString()));
    }
  }

  Future<void> forgotPass(int index) async {
    if (!forgotPassFormKey.currentState!.validate()) return;

    _identity = _getIdentity(index);
    emit(ForgotPassLoadingState());

    try {
      final response = await repo.forgotPass(identity: _identity);
      emit(ForgotPassSuccessState(message: response.message));
    } catch (e) {
      emit(ForgotPassErrorState(message: e.toString()));
    }
  }

  Future<void> resetCode(int index) async {
    final code = otpControllers.map((e) => e?.text ?? '').join();

    if (code.length < 4) {
      emit(ResetCodeErrorState(message: "Please enter the full 4-digit code."));
      return;
    }

    _identity = _getIdentity(index);
    emit(ResetCodeLoadingState());

    try {
      final response = await repo.resetCode(code: code, identity: _identity);
      _verifiedCode = code;
      _clearOtpControllers();
      emit(ResetCodeSuccessState(message: response.message));
    } catch (e) {
      emit(ResetCodeErrorState(message: e.toString()));
    }
  }

  Future<void> resetPass() async {
    if (!resetPassFormKey.currentState!.validate()) return;

    emit(ResetPassLoadingState());

    try {
      await repo.resetPass(
        identity: _identity,
        code: _verifiedCode,
        newPassword: password.text,
      );
      _clearPasswordControllers();
      _verifiedCode = '';
      emit(ResetPassSuccessState());
    } catch (e) {
      emit(ResetPassErrorState(message: e.toString()));
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

  @override
  Future<void> close() {
    emailController.dispose();
    phoneController.dispose();
    password.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
