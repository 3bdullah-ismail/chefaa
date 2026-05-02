import 'package:chefaa/presentation/patient/layout/home/patient_medication/data/data_sources/medication_data_source.dart';
import 'package:chefaa/presentation/patient/layout/home/patient_medication/data/models/Confirm_medication.dart';
import 'package:chefaa/presentation/patient/layout/home/patient_medication/data/models/Medication_list.dart';
import 'package:chefaa/presentation/patient/layout/home/patient_medication/data/models/Medication_response.dart';
import 'package:chefaa/presentation/patient/layout/home/patient_medication/data/repositories/medication_repo.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../core/error_handling/failure.dart';

@Injectable(as: MedicationRepo)
class MedicationRepoImp implements MedicationRepo {
  MedicationDataSource medicationDataSource;

  MedicationRepoImp(this.medicationDataSource);

  @override
  Future<MedicationResponse> addMedication({
    required String name,
    required String dosage,
    required String form,
    required int timesPerDay,
    required List<String> schedule,
    required String startDate,
    required String endDate,
    required bool isActive,
  }) async {
    try {
      var response = await medicationDataSource.addMedication(
        name: name,
        dosage: dosage,
        form: form,
        timesPerDay: timesPerDay,
        schedule: schedule,
        startDate: startDate,
        endDate: endDate,
        isActive: isActive,
      );
      return MedicationResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e).message;
    } catch (e) {
      throw ServerFailure.unexpectedError;
    }
  }

  @override
  Future<ConfirmMedication> confirmMedication(String medicationId) async {
    try {
      var response = await medicationDataSource.confirmMedication(medicationId);
      return ConfirmMedication.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e).message;
    } catch (e) {
      throw ServerFailure.unexpectedError;
    }
  }

  @override
  Future<MedicationResponse> deleteMedication(String medicationId) async {
   try{
      var response = await medicationDataSource.deleteMedication(medicationId);
      return MedicationResponse.fromJson(response.data);
   } on DioException catch (e) {
     throw ServerFailure.fromDioError(e).message;
   } catch (e) {
     throw ServerFailure.unexpectedError;
   }
  }

  @override
  Future<MedicationList> getMedicationList()async {
   try{
      var response = await medicationDataSource.getMedicationList();
      return MedicationList.fromJson(response.data);
   }on DioException catch (e) {
     throw ServerFailure.fromDioError(e).message;
   } catch (e) {
     throw ServerFailure.unexpectedError;
   }
  }

  @override
  Future<MedicationResponse> updateMedication({
    required String medicationId,
    required String name,
    required String dosage,
    required String form,
    required int timesPerDay,
    required List<String> schedule,
    required String startDate,
    required String endDate,
    required bool isActive,
  }) async{
    try{
      var response = await medicationDataSource.updateMedication(
        medicationId: medicationId,
        name: name,
        dosage: dosage,
        form: form,
        timesPerDay: timesPerDay,
        schedule: schedule,
        startDate: startDate,
        endDate: endDate,
        isActive: isActive,
      );
      return MedicationResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e).message;
    } catch (e) {
      throw ServerFailure.unexpectedError;
    }
  }
}
