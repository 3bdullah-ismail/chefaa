import 'package:chefaa/core/services/network_service.dart';
import 'package:chefaa/features/patient/notification/data/data_sources/patient_notific_data_source.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: PatientNotificatorDataSource)
class PatientNotificatorDataSourceImp implements PatientNotificatorDataSource{
  NetworkService networkService;
  PatientNotificatorDataSourceImp({required this.networkService});
  @override
  Future<Response<dynamic>> getNotifications() {
   return networkService.dio.get("/patient/notifications");
  }
}