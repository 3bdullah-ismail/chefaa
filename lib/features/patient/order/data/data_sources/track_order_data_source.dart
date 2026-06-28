import 'package:dio/dio.dart';

abstract class TrackOrderDataSource {
  Future<Response<dynamic>> getOrderTracking(String orderId);
  Future<Response<dynamic>> confirmOrderReceipt(String orderId);
}
