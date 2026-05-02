import 'package:chefaa/core/services/network_service.dart';
import 'package:chefaa/presentation/patient/layout/home/patient_medication/data/data_sources/medication_data_source.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: MedicationDataSource)
class MedicationDataSourceImp implements MedicationDataSource {
  NetworkService networkService;
  MedicationDataSourceImp(this.networkService);

  @override
  Future<Response<dynamic>> addMedication({
    required String name,
    required String dosage,
    required String form,
    required int timesPerDay,
    required List<String> schedule,
    required String startDate,
    required String endDate,
    required bool isActive,
  }) {
    return  networkService.dio.post(
      '/patient/medications',
      data: {
        'name': name,
        'dosage': dosage,
        'form': form,
        'timesPerDay': timesPerDay,
        'schedule': schedule,
        'startDate': startDate,
        'endDate': endDate,
        'isActive': isActive,
      },
    );
  }

  @override
  Future<Response<dynamic>> confirmMedication(String medicationId) {
   return  networkService.dio.post(
      '/patient/medications/$medicationId/confirm',
    );
  }

  @override
  Future<Response<dynamic>> deleteMedication(String medicationId) {
    return  networkService.dio.delete(
      '/patient/medications/$medicationId',
    );
  }

  @override
  Future<Response<dynamic>> getMedicationList() {
    return  networkService.dio.get(
      '/patient/my-medications',
    );
  }

  @override
  Future<Response<dynamic>> updateMedication({
    required String medicationId,
    required String name,
    required String dosage,
    required String form,
    required int timesPerDay,
    required List<String> schedule,
    required String startDate,
    required String endDate,
    required bool isActive,
  }) {
    return  networkService.dio.put(
      '/patient/medications/$medicationId',
      data: {
        'name': name,
        'dosage': dosage,
        'form': form,
        'timesPerDay': timesPerDay,
        'schedule': schedule,
        'startDate': startDate,
        'endDate': endDate,
        'isActive': isActive,
      },
    );

  }
}
