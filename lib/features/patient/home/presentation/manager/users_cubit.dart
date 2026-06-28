import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:chefaa/features/auth/data/models/auth_response.dart';
import 'package:chefaa/features/patient/home/domain/entities/user_entity.dart';
import 'package:chefaa/features/patient/home/domain/use_cases/user_usecase.dart';

part 'users_state.dart';

@lazySingleton
class UsersCubit extends Cubit<UsersState> {
  final UserUseCase _userUseCase;

  UsersCubit(this._userUseCase) : super(UsersInitial());

  static UsersCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> setUser(AuthResponse authResponse) async {
    final user = _userUseCase.fromAuthResponse(authResponse);
    await _userUseCase.saveUserToPrefs(user);
      if (!isClosed) emit(UserLoaded(user: user));
  }

  Future<void> loadUserFromPrefs() async {
      if (!isClosed) emit(UsersLoading());

    try {
      final user = await _userUseCase.loadUserFromPrefs();

      if (user != null) {
      if (!isClosed) emit(UserLoaded(user: user));
      } else {
      if (!isClosed) emit(UsersError(error: "User not found"));
      }
    } catch (e) {
      if (!isClosed) emit(UsersError(error: e.toString()));
    }
  }

  Future<void> logout() async {
    await _userUseCase.clearUserFromPrefs();
      if (!isClosed) emit(UserLoggedOut());
  }

  Future<void> getAppointments() async {}
}
