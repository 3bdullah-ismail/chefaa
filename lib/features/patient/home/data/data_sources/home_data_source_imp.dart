import 'package:chefaa/core/imports/imports.dart';
import 'package:chefaa/core/services/network_service.dart';

import 'home_data_source.dart';

@Injectable(as: HomeDataSource)
class HomeDataSourceImp implements HomeDataSource {
  NetworkService networkService;

  HomeDataSourceImp(this.networkService);

  @override
  Future<Response<dynamic>> getAppointments() async {
    return await networkService.dio.get("/appointments/my");
  }
}
