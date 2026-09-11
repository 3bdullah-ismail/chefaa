import 'package:chefaa/core/imports/imports.dart';
import 'package:chefaa/core/error_handling/failure.dart';
import 'package:chefaa/features/patient/order/data/models/orders_list_response.dart';

abstract class OrdersListRepo {
  Future<Either<Failure, OrdersListResponse>> getMyOrders();
}
