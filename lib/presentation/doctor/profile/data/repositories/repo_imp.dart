import 'package:chefaa/core/error_handling/failure.dart';
import 'package:chefaa/presentation/doctor/profile/data/models/Doctor_data.dart';
import 'package:chefaa/presentation/doctor/profile/data/models/update_doctor_profile_request.dart';
import 'package:chefaa/presentation/doctor/profile/data/repositories/repo.dart';
import 'package:chefaa/presentation/doctor/profile/domain/entities/doctor_profile_entity.dart';
import 'package:dart_either/dart_either.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../data_sources/remote_data_source/remote_data_source.dart';
import '../models/update_doctor_profile_response.dart';

@Injectable(as: DoctorProfileRepo)
class DoctorProfileRepoImp implements DoctorProfileRepo {
  DoctorProfileRemoteDataSource profileRemoteDataSource;

  DoctorProfileRepoImp(this.profileRemoteDataSource);

  @override
  Future<Either<Failure, DoctorProfileEntity>> getDoctorData() async {
    try {
      var response = await profileRemoteDataSource.getDoctorData();
      var data = DoctorData.fromJson(response.data);
      return Right(data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, DoctorProfileEntity>> upDateDoctorData(
    UpdateDoctorProfileRequest request,
  ) async {
    try {
      // Pass the typed request directly — DataSource handles Map construction
      final response = await profileRemoteDataSource.upDateDoctorData(request);
      final responseData = UpdateDoctorProfileResponse.fromJson(response.data);
      if (responseData.doctor != null) {
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
