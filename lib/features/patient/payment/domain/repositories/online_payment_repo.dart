import 'package:chefaa/core/imports/imports.dart';
import 'package:chefaa/core/error_handling/failure.dart';
import 'package:chefaa/features/patient/payment/data/models/online_payment_response.dart';

abstract class OnlinePaymentRepo {
  Future<Either<Failure, OnlinePaymentResponse>> processOnlinePayment(
    Map<String, dynamic> paymentData,
  );
}
