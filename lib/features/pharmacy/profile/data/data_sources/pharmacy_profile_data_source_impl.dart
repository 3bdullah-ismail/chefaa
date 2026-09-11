import 'package:chefaa/core/imports/imports.dart';
import 'package:chefaa/core/services/network_service.dart';
import 'package:chefaa/features/pharmacy/profile/data/data_sources/pharmacy_profile_data_source.dart';

@Injectable(as: PharmacyProfileDataSource)
class PharmacyProfileDataSourceImpl implements PharmacyProfileDataSource {
  final NetworkService _networkService;

  PharmacyProfileDataSourceImpl(this._networkService);

  @override
  Future<Response> getPharmacyProfile() {
    return _networkService.dio.get("/pharmacy/profile");
  }

  @override
  Future<Response> updatePharmacyProfile(Map<String, dynamic> body) {
    return _networkService.dio.patch("/pharmacy/profile", data: body);
  }
}
