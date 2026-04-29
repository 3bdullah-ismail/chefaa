import 'package:chefaa/presentation/patient/profile/domain/entities/user_profile_entity.dart';
import 'package:dart_either/dart_either.dart';

import '../../../../../core/error_handling/failure.dart';

abstract class ProfileRepo {
  Future<Either<Failure, UserProfileEntity>> getProfileData();

  Future<Either<Failure, UserProfileEntity>> updateProfileData(
    String? name,
    String? gender,
    num? age,
    num? height,
    num? weight,
  );

  Future<Either<Failure, UserProfileEntity>> updateMedicalData({
    required String bloodType,
    required List<String> allergiesList,
    required List<String> chronicConditionsList,
  });
}
