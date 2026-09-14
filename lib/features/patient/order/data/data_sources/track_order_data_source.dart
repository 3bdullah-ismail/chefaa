import 'package:chefaa/core/imports/imports.dart';

abstract class TrackOrderDataSource {
  Future<Response<dynamic>> getOrderTracking(String orderId);
  Future<Response<dynamic>> confirmOrderReceipt(String orderId);
}
