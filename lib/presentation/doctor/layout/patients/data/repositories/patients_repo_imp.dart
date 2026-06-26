import 'package:chefaa/presentation/doctor/layout/patients/data/data_sources/patients_data_sourse.dart';
import 'package:chefaa/presentation/doctor/layout/patients/data/models/complete/Complete_appointment.dart';
import 'package:chefaa/presentation/doctor/layout/patients/data/models/patients/Prescription.dart';
import 'package:chefaa/presentation/doctor/layout/patients/data/repositories/patients_repo.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/error_handling/failure.dart';
import '../models/Data.dart';

@Injectable(as: PatientsRepo)
class PatientsRepoImp implements PatientsRepo {
  PatientsDataSource patientsDataSource;

  PatientsRepoImp(this.patientsDataSource);

  //get patients list
  @override
  Future<List<Data>> getPatients() async {
    try {
      final response = await patientsDataSource.getPatients();

      final List dataList = response.data['data'];

      return dataList.map((e) => Data.fromJson(e)).toList();
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e).message;
    } catch (e) {
      throw ServerFailure.unexpectedError;
    }
  }

  //complete appointment
  @override
  Future<CompleteAppointment> completeAppointment({
    required String appointmentId,
  }) async {
    try {
      final response = await patientsDataSource.completeAppointment(
        appointmentId: appointmentId,
      );

      return CompleteAppointment.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e).message;
    } catch (e) {
      throw ServerFailure.unexpectedError;
    }
  }

  //create prescription
  @override
  Future<Prescription> createPrescription({
    required String appointment,
    required String diagnosis,
    required List<Map<String, dynamic>> medicines,
    required List<String> labTests,
    required List<String> imaging,
    required String nextVisit,
    required String notes,
  }) async {
    try {
      final response = await patientsDataSource.createPrescription(
        appointment: appointment,
        diagnosis: diagnosis,
        medicines: medicines,
        labTests: labTests,
        imaging: imaging,
        nextVisit: nextVisit,
        notes: notes,
      );

      return Prescription.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e).message;
    } catch (e) {
      throw ServerFailure.unexpectedError;
    }
  }

  //edit prescription
  @override
  Future<Prescription> editPrescription({
    required String appointment,
    required String diagnosis,
    required List<Map<String, dynamic>> medicines,
    required List<String> labTests,
    required List<String> imaging,
    required String nextVisit,
    required String notes,
  }) async {
    try {
      final response = await patientsDataSource.editPrescription(
        appointment: appointment,
        diagnosis: diagnosis,
        medicines: medicines,
        labTests: labTests,
        imaging: imaging,
        nextVisit: nextVisit,
        notes: notes,
      );

      return Prescription.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e).message;
    } catch (e) {
      throw ServerFailure.unexpectedError;
    }
  }

  //get prescription by appointment
  @override
  Future<Prescription> getPrescriptionByAppointment({
    required String appointmentId,
  }) async {
    try {
      final response = await patientsDataSource.getPrescriptionByAppointment(
        appointmentId: appointmentId,
      );

      return Prescription.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e).message;
    } catch (e) {
      throw ServerFailure.unexpectedError;
    }
  }

  //get previous prescriptions
  @override
  Future<List<Prescription>> getPreviousPrescriptions({
    required String appointmentId,
  }) async {
    try {
      final response = await patientsDataSource.getPreviousPrescriptions(
        appointmentId: appointmentId,
      );

      final dynamic raw = response.data['data'];

      if (raw is List) {
        return raw
            .map(
              (json) => Prescription.fromJson({'success': true, 'data': json}),
            )
            .toList();
      } else if (raw is Map<String, dynamic>) {
        // ✅ التصحيح: لف الـ raw تحت مفتاح "data" قبل التمرير
        return [
          Prescription.fromJson({'success': true, 'data': raw}),
        ];
      } else {
        return [];
      }
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e).message;
    } catch (e) {
      throw ServerFailure.unexpectedError;
    }
  }
}
