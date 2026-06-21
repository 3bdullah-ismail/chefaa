import 'package:chefaa/core/services/network_service.dart';
import 'package:chefaa/presentation/doctor/layout/patients/data/data_sources/patients_data_sourse.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';


@Injectable(as: PatientsDataSource)
class PatientsDataSourceImp  implements PatientsDataSource{
  NetworkService networkService;
  PatientsDataSourceImp(this.networkService);
  @override
  Future<Response<dynamic>> getPatients() {
   return  networkService.dio.get('/appointments/my');
  }
}
