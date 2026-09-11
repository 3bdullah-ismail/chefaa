
import 'package:chefaa/core/imports/imports.dart';
abstract class OrdersListDataSource {
  Future<Response<dynamic>> getMyOrders();
}
