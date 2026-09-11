import 'package:chefaa/core/imports/imports.dart';
import 'package:chefaa/core/services/network_service.dart';
import 'package:chefaa/features/patient/order/data/data_sources/orders_list_data_source.dart';

@Injectable(as: OrdersListDataSource)
class OrdersListDataSourceImp implements OrdersListDataSource {
  final NetworkService networkService;

  OrdersListDataSourceImp(this.networkService);

  @override
  Future<Response<dynamic>> getMyOrders() {
    return networkService.dio.get('/patient/orders');
  }
}
