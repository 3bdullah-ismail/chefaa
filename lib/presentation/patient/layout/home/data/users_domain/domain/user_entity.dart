import '../../../../../../../core/models/auth_response.dart';

class UserEntity {
  final String id;
  final String name;

  const UserEntity({required this.id, required this.name});

  factory UserEntity.fromAuthResponse(AuthResponse authResponse) {
    return UserEntity(
      id: authResponse.user?.id?.trim() ?? '',
      name: authResponse.user?.name?.trim() ?? '',
    );
  }

  factory UserEntity.empty() => const UserEntity(id: '', name: '');

  UserEntity copyWith({String? id, String? name}) {
    return UserEntity(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  bool get isEmpty => id.isEmpty && name.isEmpty;
}
