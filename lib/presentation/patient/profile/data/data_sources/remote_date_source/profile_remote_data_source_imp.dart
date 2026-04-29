import 'package:chefaa/core/services/network_service.dart';
import 'package:chefaa/presentation/patient/profile/data/data_sources/remote_date_source/profile_remote_data_source.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  NetworkService networkService;

  ProfileRemoteDataSourceImpl(this.networkService);

  @override
  Future<Response> getProfileData() {
    return networkService.dio.get("/patient/profile");
  }

  @override
  Future<Response<dynamic>> updateMedicalData({
    required String bloodType,
    required List<String> allergiesList,
    required List<String> chronicConditionsList,
  }) {
    return networkService.dio.put(
      "/patient/profile/medical-info",
      data: {
        "bloodType": bloodType,
        "allergies": allergiesList,
        "chronicConditions": chronicConditionsList,
      },
    );
  }

  @override
  Future<Response<dynamic>> updateProfileData(
    String? name,
    String? gender,
    num? age,
    num? height,
    num? weight,
  ) {
    return networkService.dio.put(
      "/patient/profile/basic-info",
      data: {
        "name": name,
        "age": age,
        "gender": gender,
        "height": height,
        "weight": weight,
      },
    );
  }
}
