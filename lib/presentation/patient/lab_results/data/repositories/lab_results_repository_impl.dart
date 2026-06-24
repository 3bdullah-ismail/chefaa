import 'dart:convert';
import 'dart:isolate';
import 'package:chefaa/core/error_handling/failure.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../data_sources/lab_results_remote_data_source.dart';
import '../models/lab_results_response.dart';
import 'lab_results_repository.dart';

@Injectable(as: LabResultsRepository)
class LabResultsRepositoryImpl implements LabResultsRepository {
  final LabResultsRemoteDataSource _remoteDataSource;

  LabResultsRepositoryImpl(this._remoteDataSource);

  @override
  Future<LabResultsResponse> getLabResults() async {
    try {
      final response = await _remoteDataSource.getLabResults();
      final body = response.data;

      final LabResultsResponse data = body is String
          ? LabResultsResponse.fromJson(
              await Isolate.run(() => jsonDecode(body)),
            )
          : LabResultsResponse.fromJson(body);

      return data;
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e).message;
    } catch (e) {
      throw ServerFailure.unexpectedError;
    }
  }
}
