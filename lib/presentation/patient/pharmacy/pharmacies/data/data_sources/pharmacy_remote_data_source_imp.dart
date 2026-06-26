import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../../../core/services/network_service.dart';
import 'pharmacy_remote_data_source.dart';

@Injectable(as: PharmacyRemoteDataSource)
class PharmacyRemoteDataSourceImp implements PharmacyRemoteDataSource {
  final NetworkService networkService;

  PharmacyRemoteDataSourceImp(this.networkService);

  @override
  Future<Response<dynamic>> getPharmacyProfile(String pharmacyId) {
    return networkService.dio.get('/patient/pharmacies/$pharmacyId/profile');
  }
}
