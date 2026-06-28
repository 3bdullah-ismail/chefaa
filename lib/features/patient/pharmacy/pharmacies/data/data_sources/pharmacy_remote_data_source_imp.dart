import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:chefaa/core/services/network_service.dart';
import 'pharmacy_remote_data_source.dart';

@Injectable(as: PharmacyRemoteDataSource)
class PharmacyRemoteDataSourceImp implements PharmacyRemoteDataSource {
  final NetworkService networkService;

  PharmacyRemoteDataSourceImp(this.networkService);

  @override
  Future<Response<dynamic>> getPharmacyProfile(String pharmacyId) {
    return networkService.dio.get('/patient/pharmacies/$pharmacyId/profile');
  }

  @override
  Future<Response<dynamic>> searchPharmacies(String query) {
    return networkService.dio.get(
      '/patient/pharmacies/search',
      queryParameters: {
        'type': 'pharmacy',
        'query': query,
      },
    );
  }

  @override
  Future<Response<dynamic>> getPharmacyMedicines(String pharmacyId) {
    return networkService.dio.get('/patient/pharmacies/$pharmacyId/medicines');
  }

  @override
  Future<Response<dynamic>> getMedicineDetails(String medicineId) {
    return networkService.dio.get('/patient/medicines/$medicineId');
  }

  @override
  Future<Response<dynamic>> addPharmacyReview(
    String pharmacyId,
    int rating,
    String comment,
  ) {
    return networkService.dio.post(
      '/patient/pharmacies/review',
      data: {
        'pharmacyId': pharmacyId,
        'rating': rating,
        'comment': comment,
      },
    );
  }

  @override
  Future<Response<dynamic>> checkoutOrder(Map<String, dynamic> checkoutData) {
    return networkService.dio.post('/patient/cart/checkout', data: checkoutData);
  }
}
