import 'package:chefaa/core/error_handling/failure.dart';
import 'package:chefaa/features/patient/order/data/models/track_order_response.dart';
import 'package:dart_either/dart_either.dart';

import 'package:chefaa/features/patient/order/data/models/confirm_receipt_response.dart';

abstract class TrackOrderRepo {
  Future<Either<Failure, TrackOrderResponse>> getOrderTracking(String orderId);
  Future<Either<Failure, ConfirmReceiptResponse>> confirmOrderReceipt(String orderId);
}
