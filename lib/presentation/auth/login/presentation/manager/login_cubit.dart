import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/services/storage_service.dart';
import '../../data/repositories/login_repo.dart';
import 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginRepo loginRepo;

  LoginCubit(this.loginRepo) : super(LoginInitial());

  TextEditingController identityController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  static LoginCubit get(context) => BlocProvider.of(context);

  Future<void> login() async {
    emit(LoginLoadingState());
    try {
      final res = await loginRepo.login(
        identity: identityController.text.trim(),
        password: passwordController.text.trim(),
      );

      await StorageService.saveToken(res.accessToken!);
      await StorageService.saveUser(res.user!);
      await StorageService.saveRole(res.user!.role!);

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

  @override
  Future<void> close() {
    identityController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
