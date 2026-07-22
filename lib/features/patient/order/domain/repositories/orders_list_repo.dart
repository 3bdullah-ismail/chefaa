import 'package:chefaa/core/error_handling/failure.dart';
import 'package:chefaa/features/patient/order/data/models/orders_list_response.dart';
import 'package:dart_either/dart_either.dart';

abstract class OrdersListRepo {
  Future<Either<Failure, OrdersListResponse>> getMyOrders();
}
