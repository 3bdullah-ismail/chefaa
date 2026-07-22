import 'package:chefaa/core/error_handling/failure.dart';
import 'package:chefaa/features/patient/order/data/data_sources/orders_list_data_source.dart';
import 'package:chefaa/features/patient/order/data/models/orders_list_response.dart';
import 'package:chefaa/features/patient/order/domain/repositories/orders_list_repo.dart';
import 'package:dart_either/dart_either.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OrdersListRepo)
class OrdersListRepoImpl implements OrdersListRepo {
  final OrdersListDataSource remoteDataSource;

  OrdersListRepoImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, OrdersListResponse>> getMyOrders() async {
    try {
      final response = await remoteDataSource.getMyOrders();
      final model = OrdersListResponse.fromJson(response.data);
      return Right(model);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
