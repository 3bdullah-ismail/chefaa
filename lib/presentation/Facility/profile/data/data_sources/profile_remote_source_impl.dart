import 'package:chefaa/core/services/network_service.dart';
import 'package:chefaa/presentation/Facility/profile/data/data_sources/profile_remote_source.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRemoteSource)
class ProfileRemoteSourceImpl implements ProfileRemoteSource {
  final NetworkService _networkService;

  ProfileRemoteSourceImpl(this._networkService);

  @override
  Future<Response> getProfile() async {
    return _networkService.dio.get("/lab/profile");
  }

  @override
  Future<Response> updateProfile(Map<String, dynamic> body) async {
    return _networkService.dio.patch("/lab/update-profile", data: body);
  }
}

