


import '../../data/users_domain/domain/user_entity.dart';

sealed class UsersState {}
final class UsersInitial extends UsersState{}
final class UsersLoading extends UsersState{}
final class UsersError extends UsersState{
  final String? error;
  UsersError({this.error});
}
class UserLoaded extends UsersState {
  final UserEntity user;
  UserLoaded({required this.user});
}
class UserLoggedOut extends UsersState {}