import 'package:chefaa/core/services/share_service.dart';
import 'package:injectable/injectable.dart';

import 'package:chefaa/features/auth/data/models/auth_response.dart';
import '../entities/user_entity.dart';

@injectable
class UserUseCase {
  UserEntity fromAuthResponse(AuthResponse authResponse) {
    return UserEntity.fromAuthResponse(authResponse);
  }

  Future<void> saveUserToPrefs(UserEntity user) async {
    await SharedServices.saveString('userId', user.id.trim());
    await SharedServices.saveString('userName', user.name.trim());
  }

  Future<UserEntity?> loadUserFromPrefs() async {
    final id = await SharedServices.getString('userId');
    final name = await SharedServices.getString('userName');

    if (id == null || id.isEmpty) {
      return null;
    }

    return UserEntity(id: id.trim(), name: name?.trim() ?? '');
  }

  Future<void> clearUserFromPrefs() async {
    await SharedServices.saveString('userId', '');
    await SharedServices.saveString('userName', '');
  }
}
