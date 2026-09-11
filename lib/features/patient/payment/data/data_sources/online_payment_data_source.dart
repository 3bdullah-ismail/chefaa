
import 'package:chefaa/core/imports/imports.dart';
abstract class OnlinePaymentDataSource {
  Future<Response<dynamic>> processOnlinePayment(Map<String, dynamic> paymentData);
}
