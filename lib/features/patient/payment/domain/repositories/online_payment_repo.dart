import 'package:chefaa/core/error_handling/failure.dart';
import 'package:chefaa/features/patient/payment/data/models/online_payment_response.dart';
import 'package:dart_either/dart_either.dart';

abstract class OnlinePaymentRepo {
  Future<Either<Failure, OnlinePaymentResponse>> processOnlinePayment(
    Map<String, dynamic> paymentData,
  );
}
