import 'package:chefaa/core/services/network_service.dart';
import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/services/storage_service.dart';
import 'complete_data_source.dart';

@Injectable(as: CompleteDataSource)
class CompleteDataSourceImp implements CompleteDataSource {
  NetworkService networkService;

  CompleteDataSourceImp({required this.networkService});

  @override
  Future<Response<dynamic>> completeSignUp({
    required double? weight,
    required int? height,
    required String? bloodType,
    required String? gender,
    required int? age,
    required List<String>? chronicDiseases,
    required List<String>? allergies,
  }) async {
    final token = await StorageService.getToken();
    return networkService.dio.put(
      "/patient/profile",
      data: {
        "weight": weight,
        "height": height,
        "bloodType": bloodType,
        "gender": gender,
        "age": age,
        "chronicDiseases": chronicDiseases,
        "allergies": allergies,
      },
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
  }
}
