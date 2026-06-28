import 'package:chefaa/core/services/network_service.dart';
import 'package:chefaa/features/patient/pharmacy/pharmacies/data/data_sources/pharmacy_patient_data_source.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: PharmacyPatientDataSource)
class PharmacyPatientDataSourceImp implements PharmacyPatientDataSource {
  NetworkService networkService;

  PharmacyPatientDataSourceImp({required this.networkService});

  @override
  Future<Response<dynamic>> addPharmacyReviews({
    required String pharmacyId,
    required int rating,
    required String comment,
  }) {
    return networkService.dio.post(
      "patient/pharmacies/review",
      data: {
        "pharmacy_id": pharmacyId,
        "rating": rating,
        "comment": comment,
      },
    );
  }

  @override
  Future<Response<dynamic>> getPharmacyMedicines({required String pharmacyId}) {
    return networkService.dio.get("/patient/pharmacies/$pharmacyId/medicines");
  }

  @override
  Future<Response<dynamic>> pharmacyProfile({required String pharmacyId}) {
    return networkService.dio.get("/patient/pharmacies/$pharmacyId/profile");
  }

  @override
  Future<Response<dynamic>> searchPharmacyAndMedicine({
    required String searchQuery,
    required int type,
  }) {
  return networkService.dio.get(
      "/patient/pharmacies/search",
      queryParameters: {
        "type": type,
        "search": searchQuery,
      },
    );
  }
}
