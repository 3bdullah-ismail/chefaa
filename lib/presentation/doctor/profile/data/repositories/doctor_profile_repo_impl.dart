import 'package:chefaa/core/error_handling/failure.dart';
import 'package:chefaa/presentation/doctor/profile/data/data_sources/local_data_source/doctor_profile_local_data_source.dart';
import 'package:chefaa/presentation/doctor/profile/data/data_sources/remote_data_source/remote_data_source.dart';
import 'package:chefaa/presentation/doctor/profile/data/models/doctor_data.dart';
import 'package:chefaa/presentation/doctor/profile/data/models/update_doctor_profile_response.dart';
import 'package:chefaa/presentation/doctor/profile/domain/entities/doctor_profile_entity.dart';
import 'package:chefaa/presentation/doctor/profile/domain/repositories/doctor_profile_repo.dart';
import 'package:dart_either/dart_either.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: DoctorProfileRepo)
class DoctorProfileRepoImpl implements DoctorProfileRepo {
  final DoctorProfileRemoteDataSource profileRemoteDataSource;
  final DoctorProfileLocalDataSource profileLocalDataSource;

  DoctorProfileRepoImpl(
    this.profileRemoteDataSource,
    this.profileLocalDataSource,
  );

  @override
  Future<Either<Failure, DoctorProfileEntity>> getDoctorData() async {
    try {
      final response = await profileRemoteDataSource.getDoctorData();
      final data = DoctorData.fromJson(response.data);
      await profileLocalDataSource.cacheDoctorProfile(data);
      return Right(data);
    } on DioException catch (e) {
      final cached = await profileLocalDataSource.getCachedDoctorProfile();
      if (cached != null) {
        return Right(cached);
      }
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      final cached = await profileLocalDataSource.getCachedDoctorProfile();
      if (cached != null) {
        return Right(cached);
      }
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, DoctorProfileEntity>> upDateDoctorData(
    DoctorProfileEntity request,
  ) async {
    try {
      final response = await profileRemoteDataSource.upDateDoctorData(request);
      final responseData = UpdateDoctorProfileResponse.fromJson(response.data);
      if (responseData.doctor != null) {
        await profileLocalDataSource.cacheDoctorProfile(responseData.doctor!);
        return Right(responseData.doctor!);
      } else {
        return Left(
          ServerFailure('Failed to update profile: empty doctor data'),
        );
      }
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }
}
