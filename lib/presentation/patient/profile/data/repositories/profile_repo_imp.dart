import 'package:chefaa/core/error_handling/failure.dart';
import 'package:chefaa/presentation/patient/profile/data/models/profile_response.dart';
import 'package:chefaa/presentation/patient/profile/data/models/update_response.dart';
import 'package:chefaa/presentation/patient/profile/data/repositories/profile_repo.dart';
import 'package:chefaa/presentation/patient/profile/domain/entities/user_profile_entity.dart';
import 'package:dart_either/dart_either.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../data_sources/remote_date_source/profile_remote_data_source.dart';

@Injectable(as: ProfileRepo)
class ProfileRepoImpl implements ProfileRepo {
  ProfileRemoteDataSource profileRemoteDataSource;

  ProfileRepoImpl(this.profileRemoteDataSource);

  @override
  Future<Either<Failure, UserProfileEntity>> getProfileData() async {
    try {
      var response = await profileRemoteDataSource.getProfileData();
      var data = ProfileResponse.fromJson(response.data);
      return Right(data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, UserProfileEntity>> updateProfileData(
    String? name,
    String? gender,
    num? age,
    num? height,
    num? weight,
  ) async {
    try {
      var response = await profileRemoteDataSource.updateProfileData(
        name,
        gender,
        age,
        height,
        weight,
      );
      var data = UpdateResponse.fromJson(response.data);
      return Right(data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, UserProfileEntity>> updateMedicalData({
    required String bloodType,
    required List<String> allergiesList,
    required List<String> chronicConditionsList,
  }) {
    // TODO: implement updateMedicalData
    throw UnimplementedError();
  }
}
