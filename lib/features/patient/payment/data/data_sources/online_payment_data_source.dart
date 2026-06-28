import 'package:dio/dio.dart';

abstract class OnlinePaymentDataSource {
  Future<Response<dynamic>> processOnlinePayment(Map<String, dynamic> paymentData);
}
