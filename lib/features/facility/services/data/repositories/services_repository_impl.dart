import 'dart:convert';
import 'dart:isolate';

import 'package:chefaa/core/error_handling/failure.dart';
import 'package:chefaa/core/services/hive_service.dart';
import 'package:chefaa/features/facility/services/data/data_sources/services_remote_source.dart';
import 'package:chefaa/features/facility/services/data/models/add_service_response.dart';
import 'package:chefaa/features/facility/services/data/models/get_services_response.dart';
import 'package:chefaa/features/facility/services/data/repositories/services_repository.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ServicesRepository)
class ServicesRepositoryImpl implements ServicesRepository {
  final ServicesRemoteSource _servicesRemoteSource;
  static const String _cacheKey = 'facility_services_cache';

  ServicesRepositoryImpl(this._servicesRemoteSource);

  @override
  Future<AddServiceResponse> addService({
    required String name,
    required String category,
    required num price,
    required String estimatedTime,
    String? sessionDuration,
    String? instructions,
    String? imagePath,
  }) async {
    try {
      final response = await _servicesRemoteSource.addService(
        name: name,
        category: category,
        price: price,
        estimatedTime: estimatedTime,
        sessionDuration: sessionDuration,
        instructions: instructions,
        imagePath: imagePath,
      );

      final body = response.data;
      final AddServiceResponse data = body is String
          ? AddServiceResponse.fromJson(
              await Isolate.run(() => jsonDecode(body)),
            )
          : AddServiceResponse.fromJson(body);

      // Invalidate services cache
      await HiveService.delete(HiveBoxes.facilityBox, _cacheKey);

      return data;
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e).message;
    } catch (e) {
      throw ServerFailure.unexpectedError;
    }
  }

  @override
  Future<GetServicesResponse> getMyServices({String? search}) async {
    final bool isSearchEmpty = search == null || search.trim().isEmpty;
    try {
      final response = await _servicesRemoteSource.getMyServices(
        search: search,
      );
      final body = response.data;
      final GetServicesResponse data = body is String
          ? GetServicesResponse.fromJson(
              await Isolate.run(() => jsonDecode(body)),
            )
          : GetServicesResponse.fromJson(body);

      if (isSearchEmpty) {
        await HiveService.put(HiveBoxes.facilityBox, _cacheKey, body);
      }
      return data;
    } on DioException catch (e) {
      if (isSearchEmpty) {
        final cachedBody = await HiveService.get<dynamic>(
          HiveBoxes.facilityBox,
          _cacheKey,
        );
        if (cachedBody != null) {
          try {
            final decoded = cachedBody is String
                ? await Isolate.run(() => jsonDecode(cachedBody))
                : cachedBody;
            return GetServicesResponse.fromJson(decoded);
          } catch (_) {}
        }
      }
      throw ServerFailure.fromDioError(e).message;
    } catch (e) {
      if (isSearchEmpty) {
        final cachedBody = await HiveService.get<dynamic>(
          HiveBoxes.facilityBox,
          _cacheKey,
        );
        if (cachedBody != null) {
          try {
            final decoded = cachedBody is String
                ? await Isolate.run(() => jsonDecode(cachedBody))
                : cachedBody;
            return GetServicesResponse.fromJson(decoded);
          } catch (_) {}
        }
      }
      throw ServerFailure.unexpectedError;
    }
  }

  @override
  Future<AddServiceResponse> toggleService(String serviceId) async {
    try {
      final response = await _servicesRemoteSource.toggleService(serviceId);
      final body = response.data;
      final AddServiceResponse data = body is String
          ? AddServiceResponse.fromJson(
              await Isolate.run(() => jsonDecode(body)),
            )
          : AddServiceResponse.fromJson(body);

      // Invalidate services cache
      await HiveService.delete(HiveBoxes.facilityBox, _cacheKey);

      return data;
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e).message;
    } catch (e) {
      throw ServerFailure.unexpectedError;
    }
  }
}

