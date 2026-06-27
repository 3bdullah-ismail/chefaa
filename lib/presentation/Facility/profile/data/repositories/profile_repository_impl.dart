import 'dart:convert';
import 'dart:isolate';

import 'package:chefaa/core/error_handling/failure.dart';
import 'package:chefaa/core/services/hive_service.dart';
import 'package:chefaa/presentation/Facility/profile/data/data_sources/profile_remote_source.dart';
import 'package:chefaa/presentation/Facility/profile/data/models/get_profile_response.dart';
import 'package:chefaa/presentation/Facility/profile/data/repositories/profile_repository.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';


@Injectable(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteSource _profileRemoteSource;
  static const String _cacheKey = 'facility_profile_cache';

  ProfileRepositoryImpl(this._profileRemoteSource);

  @override
  Future<GetProfileResponse> getProfile() async {
    try {
      final response = await _profileRemoteSource.getProfile();
      final body = response.data;
      final GetProfileResponse data = body is String
          ? GetProfileResponse.fromJson(
              await Isolate.run(() => jsonDecode(body)),
            )
          : GetProfileResponse.fromJson(body);

      await HiveService.put(HiveBoxes.facilityBox, _cacheKey, body);
      return data;
    } on DioException catch (e) {
      final cachedBody = await HiveService.get<dynamic>(
        HiveBoxes.facilityBox,
        _cacheKey,
      );
      if (cachedBody != null) {
        try {
          final decoded = cachedBody is String
              ? await Isolate.run(() => jsonDecode(cachedBody))
              : cachedBody;
          return GetProfileResponse.fromJson(decoded);
        } catch (_) {}
      }
      throw ServerFailure.fromDioError(e).message;
    } catch (e) {
      final cachedBody = await HiveService.get<dynamic>(
        HiveBoxes.facilityBox,
        _cacheKey,
      );
      if (cachedBody != null) {
        try {
          final decoded = cachedBody is String
              ? await Isolate.run(() => jsonDecode(cachedBody))
              : cachedBody;
          return GetProfileResponse.fromJson(decoded);
        } catch (_) {}
      }
      throw ServerFailure.unexpectedError;
    }
  }

  @override
  Future<GetProfileResponse> updateProfile(Map<String, dynamic> body) async {
    try {
      final response = await _profileRemoteSource.updateProfile(body);
      final responseBody = response.data;
      final GetProfileResponse data = responseBody is String
          ? GetProfileResponse.fromJson(
              await Isolate.run(() => jsonDecode(responseBody)),
            )
          : GetProfileResponse.fromJson(responseBody);

      await HiveService.put(HiveBoxes.facilityBox, _cacheKey, responseBody);
      return data;
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e).message;
    } catch (e) {
      throw ServerFailure.unexpectedError;
    }
  }
}

