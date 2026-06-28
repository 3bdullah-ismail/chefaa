import 'package:chefaa/core/error_handling/failure.dart';
import 'package:chefaa/features/patient/payment/data/data_sources/online_payment_data_source.dart';
import 'package:chefaa/features/patient/payment/data/models/online_payment_response.dart';
import 'package:chefaa/features/patient/payment/domain/repositories/online_payment_repo.dart';
import 'package:dart_either/dart_either.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OnlinePaymentRepo)
class OnlinePaymentRepoImpl implements OnlinePaymentRepo {
  final OnlinePaymentDataSource remoteDataSource;

  OnlinePaymentRepoImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, OnlinePaymentResponse>> processOnlinePayment(
    Map<String, dynamic> paymentData,
  ) async {
    try {
      final response = await remoteDataSource.processOnlinePayment(paymentData);
      final model = OnlinePaymentResponse.fromJson(response.data);
      return Right(model);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
