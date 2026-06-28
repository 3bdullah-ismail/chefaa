import 'package:dio/dio.dart';

abstract class PharmacyInventoryDataSource {
  Future<Response> addMedicine(Map<String, dynamic> body);
  Future<Response> getMedicines({String? search, String? filter});
  Future<Response> getLowStock({String? search});
  Future<Response> searchMedicines(String query);
}
