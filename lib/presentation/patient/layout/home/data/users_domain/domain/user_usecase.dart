import 'package:chefaa/core/services/share_service.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../core/models/auth_response.dart';
import 'user_entity.dart';

@injectable
class UserUseCase {
  UserEntity fromAuthResponse(AuthResponse authResponse) {
	return UserEntity(
	  id: authResponse.user?.id ?? '',
	  name: authResponse.user?.name ?? '',
	);
  }

  Future<void> saveUserToPrefs(UserEntity user) async {
	await SharedServices.saveString('userId', user.id);
	await SharedServices.saveString('userName', user.name);
  }

  Future<UserEntity?> loadUserFromPrefs() async {
	final id = await SharedServices.getString('userId');
	final name = await SharedServices.getString('userName');

	if (id == null || id.isEmpty) {
	  return null;
	}

	return UserEntity(id: id, name: name ?? '');
  }

  Future<void> clearUserFromPrefs() async {
	await SharedServices.saveString('userId', '');
	await SharedServices.saveString('userName', '');
  }
}

