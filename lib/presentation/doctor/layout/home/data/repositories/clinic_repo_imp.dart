import 'package:chefaa/presentation/doctor/layout/home/data/data_sources/clinic_data_source.dart';
import 'package:chefaa/presentation/doctor/layout/home/data/models/Clinic_response.dart';
import 'package:chefaa/presentation/doctor/layout/home/data/repositories/clinic_repo.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/error_handling/failure.dart';
import '../models/Clinics_response.dart';

@Injectable(as: ClinicRepo)
class ClinicRepoImp implements ClinicRepo {
  ClinicDataSource clinicDataSource;

  ClinicRepoImp(this.clinicDataSource);

  //Add clinic repo
  @override
  Future<ClinicResponse> addClinics({
    required String? name,
    required String? address,
    required String? city,
    required num? price,
    required String? operatingLicense,
    required Map<String, dynamic>? location,
    required Map<String, dynamic>? schedule,
  }) {
    // TODO: implement addClinics
    throw UnimplementedError();
  }

  //Delete clinic repo
  @override
  Future<ClinicResponse> deleteClinics({required String clinicID}) async {
    try {
      final response = await clinicDataSource.deleteClinics(clinicID: clinicID);
      if (response.statusCode == 200) {
        return ClinicResponse.fromJson(response.data);
      } else {
        throw Exception("Failed to delete clinic");
      }
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e).message;
    } catch (e) {
      throw ServerFailure.unexpectedError;
    }
  }

  //Get clinic by ID repo
  @override
  Future<ClinicResponse> getClinicByID({required String clinicID}) async {
    try {
      final response = await clinicDataSource.getClinicByID(clinicID: clinicID);
      if (response.statusCode == 200) {
        return ClinicResponse.fromJson(response.data);
      } else {
        throw Exception("Failed to get clinic by ID");
      }
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e).message;
    } catch (e) {
      throw ServerFailure.unexpectedError;
    }
  }

  //Get clinics repo
  @override
  Future<ClinicsResponse> getClinics({required String doctorID}) async {
    try {
      final response = await clinicDataSource.getClinics(doctorID: doctorID);
      if (response.statusCode == 200) {
        return ClinicsResponse.fromJson(response.data);
      } else {
        throw Exception("Failed to get clinics");
      }
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e).message;
    } catch (e) {
      throw ServerFailure.unexpectedError;
    }
  }

  //Update clinic repo
  @override
  Future<ClinicResponse> updateClinics({
    required String clinicID,
    required String? name,
    required String? address,
    required String? city,
    required num? price,
    required String? operatingLicense,
    required Map<String, dynamic>? location,
    required Map<String, dynamic>? schedule,
  }) async {
    try {
      final response = await clinicDataSource.updateClinics(
        clinicID: clinicID,
        name: name,
        address: address,
        city: city,
        price: price,
        operatingLicense: operatingLicense,
        location: location,
        schedule: schedule,
      );

      if (response.statusCode == 200) {
        return ClinicResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to update clinic');
      }
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e).message;
    } catch (e) {
      throw ServerFailure.unexpectedError;
    }
  }
}
