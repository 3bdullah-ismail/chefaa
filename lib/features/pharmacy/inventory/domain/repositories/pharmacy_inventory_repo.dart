import 'package:chefaa/features/pharmacy/inventory/data/models/add_medicine_response.dart';
import 'package:chefaa/features/pharmacy/inventory/data/models/get_medicines_response.dart';
import 'package:chefaa/features/pharmacy/inventory/data/models/get_low_stock_response.dart';

abstract class PharmacyInventoryRepo {
  Future<AddMedicineResponse> addMedicine(Map<String, dynamic> body);
  Future<GetMedicinesResponse> getMedicines({String? search, String? filter});
  Future<GetLowStockResponse> getLowStock({String? search});
  Future<GetMedicinesResponse> searchMedicines(String query);
}
