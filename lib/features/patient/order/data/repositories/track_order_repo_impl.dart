import 'package:chefaa/core/error_handling/failure.dart';
import 'package:chefaa/features/patient/order/data/data_sources/track_order_data_source.dart';
import 'package:chefaa/features/patient/order/data/models/track_order_response.dart';
import 'package:chefaa/features/patient/order/domain/repositories/track_order_repo.dart';
import 'package:dart_either/dart_either.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:chefaa/features/patient/order/data/models/confirm_receipt_response.dart';

@Injectable(as: TrackOrderRepo)
class TrackOrderRepoImpl implements TrackOrderRepo {
  final TrackOrderDataSource remoteDataSource;

  TrackOrderRepoImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, TrackOrderResponse>> getOrderTracking(String orderId) async {
    try {
      final response = await remoteDataSource.getOrderTracking(orderId);
      final model = TrackOrderResponse.fromJson(response.data);
      return Right(model);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ConfirmReceiptResponse>> confirmOrderReceipt(String orderId) async {
    try {
      final response = await remoteDataSource.confirmOrderReceipt(orderId);
      final model = ConfirmReceiptResponse.fromJson(response.data);
      return Right(model);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
