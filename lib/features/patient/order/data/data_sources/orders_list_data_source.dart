import 'package:dio/dio.dart';

abstract class OrdersListDataSource {
  Future<Response<dynamic>> getMyOrders();
}
