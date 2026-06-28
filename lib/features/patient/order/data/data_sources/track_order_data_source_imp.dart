import 'package:chefaa/core/services/network_service.dart';
import 'package:chefaa/features/patient/order/data/data_sources/track_order_data_source.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: TrackOrderDataSource)
class TrackOrderDataSourceImp implements TrackOrderDataSource {
  final NetworkService networkService;

  TrackOrderDataSourceImp(this.networkService);

  @override
  Future<Response<dynamic>> getOrderTracking(String orderId) {
    return networkService.dio.get('/patient/orders/track/$orderId');
  }

  @override
  Future<Response<dynamic>> confirmOrderReceipt(String orderId) {
    return networkService.dio.post(
      '/patient/orders/confirm-receipt',
      data: {'orderId': orderId},
    );
  }
}
