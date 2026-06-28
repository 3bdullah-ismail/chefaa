import 'package:chefaa/core/services/network_service.dart';
import 'package:chefaa/features/pharmacy/settings/data/data_sources/pharmacy_settings_data_source.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: PharmacySettingsDataSource)
class PharmacySettingsDataSourceImpl implements PharmacySettingsDataSource {
  final NetworkService _networkService;

  PharmacySettingsDataSourceImpl(this._networkService);

  @override
  Future<Response> updateStatus(Map<String, dynamic> body) {
    return _networkService.dio.patch("/pharmacy/settings/status", data: body);
  }
}
