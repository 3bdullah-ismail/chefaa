import 'package:dart_either/dart_either.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/error_handling/failure.dart';
import '../../domain/repositories/pharmacy_profile_repo.dart';
import '../data_sources/pharmacy_remote_data_source.dart';
import '../models/pharmacy_profile_model.dart';

@Injectable(as: PharmacyProfileRepo)
class PharmacyProfileRepoImp implements PharmacyProfileRepo {
  final PharmacyRemoteDataSource remoteDataSource;

  PharmacyProfileRepoImp(this.remoteDataSource);

  @override
  Future<Either<Failure, PharmacyProfileModel>> getPharmacyProfile(String pharmacyId) async {
    try {
      final response = await remoteDataSource.getPharmacyProfile(pharmacyId);
      final model = PharmacyProfileModel.fromJson(response.data['data']);
      return Right(model);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
