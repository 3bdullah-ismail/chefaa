import 'package:chefaa/core/services/network_service.dart';
import 'package:chefaa/features/patient/payment/data/data_sources/online_payment_data_source.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OnlinePaymentDataSource)
class OnlinePaymentDataSourceImp implements OnlinePaymentDataSource {
  final NetworkService networkService;

  OnlinePaymentDataSourceImp(this.networkService);

  @override
  Future<Response<dynamic>> processOnlinePayment(Map<String, dynamic> paymentData) {
    return networkService.dio.post('/patient/cart/payment-online', data: paymentData);
  }
}
