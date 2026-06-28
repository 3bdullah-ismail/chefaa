import 'dart:convert';
import 'dart:isolate';
import 'package:chefaa/core/error_handling/failure.dart';
import 'package:chefaa/features/pharmacy/inventory/data/data_sources/pharmacy_inventory_data_source.dart';
import 'package:chefaa/features/pharmacy/inventory/data/models/add_medicine_response.dart';
import 'package:chefaa/features/pharmacy/inventory/data/models/get_medicines_response.dart';
import 'package:chefaa/features/pharmacy/inventory/data/models/get_low_stock_response.dart';
import 'package:chefaa/features/pharmacy/inventory/domain/repositories/pharmacy_inventory_repo.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: PharmacyInventoryRepo)
class PharmacyInventoryRepoImpl implements PharmacyInventoryRepo {
  final PharmacyInventoryDataSource pharmacyInventoryDataSource;

  PharmacyInventoryRepoImpl({required this.pharmacyInventoryDataSource});

  @override
  Future<AddMedicineResponse> addMedicine(Map<String, dynamic> body) async {
    try {
      final response = await pharmacyInventoryDataSource.addMedicine(body);
      final responseBody = response.data;
      AddMedicineResponse data;
      if (responseBody is String) {
        final decoded = await Isolate.run(() => jsonDecode(responseBody));
        data = AddMedicineResponse.fromJson(
          decoded as Map<String, dynamic>,
        );
      } else {
        data = AddMedicineResponse.fromJson(
          responseBody as Map<String, dynamic>,
        );
      }
      return data;
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e).message;
    } catch (e) {
      throw ServerFailure.unexpectedError;
    }
  }

  @override
  Future<GetMedicinesResponse> getMedicines({String? search, String? filter}) async {
    try {
      final response = await pharmacyInventoryDataSource.getMedicines(
        search: search,
        filter: filter,
      );
      final responseBody = response.data;
      GetMedicinesResponse data;
      if (responseBody is String) {
        final decoded = await Isolate.run(() => jsonDecode(responseBody));
        data = GetMedicinesResponse.fromJson(
          decoded as Map<String, dynamic>,
        );
      } else {
        data = GetMedicinesResponse.fromJson(
          responseBody as Map<String, dynamic>,
        );
      }
      return data;
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e).message;
    } catch (e) {
      throw ServerFailure.unexpectedError;
    }
  }

  @override
  Future<GetLowStockResponse> getLowStock({String? search}) async {
    try {
      final response = await pharmacyInventoryDataSource.getLowStock(search: search);
      final responseBody = response.data;
      GetLowStockResponse data;
      if (responseBody is String) {
        final decoded = await Isolate.run(() => jsonDecode(responseBody));
        data = GetLowStockResponse.fromJson(
          decoded as Map<String, dynamic>,
        );
      } else {
        data = GetLowStockResponse.fromJson(
          responseBody as Map<String, dynamic>,
        );
      }
      return data;
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e).message;
    } catch (e) {
      throw ServerFailure.unexpectedError;
    }
  }

  @override
  Future<GetMedicinesResponse> searchMedicines(String query) async {
    try {
      final response = await pharmacyInventoryDataSource.searchMedicines(query);
      final responseBody = response.data;
      GetMedicinesResponse data;
      if (responseBody is String) {
        final decoded = await Isolate.run(() => jsonDecode(responseBody));
        data = GetMedicinesResponse.fromJson(
          decoded as Map<String, dynamic>,
        );
      } else {
        data = GetMedicinesResponse.fromJson(
          responseBody as Map<String, dynamic>,
        );
      }
      return data;
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e).message;
    } catch (e) {
      throw ServerFailure.unexpectedError;
    }
  }
}
