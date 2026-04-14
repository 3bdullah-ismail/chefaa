import 'package:chefaa/presentation/patient/layout/home/presentation/manager/users_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../core/models/auth_response.dart';
import '../../data/repositories/home_repo.dart';
import '../../data/users_domain/domain/user_usecase.dart';


@injectable
class UsersCubit extends Cubit<UsersState> {
  final UserUseCase _userUseCase;

  UsersCubit(this._userUseCase) : super(UsersInitial());

  static UsersCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> setUser(AuthResponse authResponse) async {
    final user = _userUseCase.fromAuthResponse(authResponse);
    await _userUseCase.saveUserToPrefs(user);

    emit(UserLoaded(user: user));
  }

  Future<void> loadUserFromPrefs() async {
    emit(UsersLoading());

    try {
      final user = await _userUseCase.loadUserFromPrefs();

      if (user != null) {
        emit(UserLoaded(user: user));
      } else {
        emit(UsersError(error: "User not found"));
      }
    } catch (e) {
      emit(UsersError(error: e.toString()));
    }
  }

  Future<void> logout() async {
    await _userUseCase.clearUserFromPrefs();
    emit(UserLoggedOut());
  }

  Future<void> getAppointments() async {

  }

}