import '../models/Clinic_response.dart';
import '../models/Clinics_response.dart';

abstract class ClinicRepo {
  Future<ClinicsResponse> getClinics({required String doctorID});

  Future<ClinicResponse> addClinics({
    required String? name,
    required String? address,
    required String? city,
    required num? price,
    required String? operatingLicense,
    required Map<String, dynamic>? location,
    required Map<String, dynamic>? schedule,
  });

  Future<ClinicResponse> deleteClinics({required String clinicID});

  Future<ClinicResponse> updateClinics({
    required String clinicID,
    required String? name,
    required String? address,
    required String? city,
    required num? price,
    required String? operatingLicense,
    required Map<String, dynamic>? location,
    required Map<String, dynamic>? schedule,
  });

  Future<ClinicResponse> getClinicByID({required String clinicID});
}
