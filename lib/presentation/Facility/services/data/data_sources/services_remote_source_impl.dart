import 'package:chefaa/core/services/network_service.dart';
import 'package:chefaa/presentation/facility/services/data/data_sources/services_remote_source.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ServicesRemoteSource)
class ServicesRemoteSourceImpl extends ServicesRemoteSource {
  final NetworkService _networkService;

  ServicesRemoteSourceImpl(this._networkService);

  @override
  Future<Response> addService({
    required String name,
    required String category,
    required num price,
    required String estimatedTime,
    String? sessionDuration,
    String? instructions,
    String? imagePath,
  }) async {
    if (category.toLowerCase() == 'scan') {
      final Map<String, dynamic> data = {
        "name": name,
        "category": category,
        "price": price,
        "estimatedTime": estimatedTime,
        if (sessionDuration != null && sessionDuration.isNotEmpty)
          "sessionDuration": sessionDuration,
      };

      if (imagePath != null && imagePath.isNotEmpty) {
        final filename = imagePath.split('/').last;
        data["imageUrl"] = await MultipartFile.fromFile(
          imagePath,
          filename: filename,
        );
      }

      final formData = FormData.fromMap(data);

      return _networkService.dio.post(
        "/lab/add-service",
        data: formData,
        options: Options(contentType: Headers.multipartFormDataContentType),
      );
    } else {
      final Map<String, dynamic> data = {
        "name": name,
        "category": category,
        "price": price,
        "estimatedTime": estimatedTime,
        if (instructions != null && instructions.isNotEmpty)
          "instructions": instructions,
      };

      return _networkService.dio.post(
        "/lab/add-service",
        data: data,
        options: Options(contentType: Headers.jsonContentType),
      );
    }
  }

  @override
  Future<Response> getMyServices({String? search}) async {
    return _networkService.dio.get(
      "/lab/my-services",
      queryParameters: {
        if (search != null && search.isNotEmpty) "search": search,
      },
    );
  }

  @override
  Future<Response> toggleService(String serviceId) async {
    return _networkService.dio.patch("/lab/toggle-service/$serviceId");
  }
}
