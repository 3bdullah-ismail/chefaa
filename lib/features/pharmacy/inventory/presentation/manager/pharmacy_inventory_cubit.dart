import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:chefaa/features/pharmacy/inventory/domain/repositories/pharmacy_inventory_repo.dart';
import 'package:chefaa/features/pharmacy/inventory/data/models/add_medicine_response.dart';
import 'package:chefaa/features/pharmacy/inventory/data/models/get_medicines_response.dart';
import 'package:chefaa/features/pharmacy/inventory/data/models/get_low_stock_response.dart';

part 'pharmacy_inventory_state.dart';

@injectable
class PharmacyInventoryCubit extends Cubit<PharmacyInventoryState> {
  final PharmacyInventoryRepo pharmacyInventoryRepo;

  PharmacyInventoryCubit(this.pharmacyInventoryRepo)
      : super(PharmacyInventoryInitial());

  Future<void> addMedicine(Map<String, dynamic> body) async {
      if (!isClosed) emit(AddMedicineLoading());
    try {
      final response = await pharmacyInventoryRepo.addMedicine(body);
      if (!isClosed) emit(AddMedicineSuccess(response));
    } catch (e) {
      if (!isClosed) emit(AddMedicineError(e.toString()));
    }
  }

  Future<void> getMedicines({String? search, String? filter}) async {
      if (!isClosed) emit(GetMedicinesLoading());
    try {
      if (search != null && search.trim().isNotEmpty) {
        final response = await pharmacyInventoryRepo.searchMedicines(search.trim());
      if (!isClosed) emit(GetMedicinesSuccess(response));
      } else if (filter == "low") {
        final response = await pharmacyInventoryRepo.getLowStock(
          search: search,
        );
      if (!isClosed) emit(GetLowStockSuccess(response));
      } else {
        final response = await pharmacyInventoryRepo.getMedicines(
          search: search,
          filter: filter,
        );
      if (!isClosed) emit(GetMedicinesSuccess(response));
      }
    } catch (e) {
      if (!isClosed) emit(GetMedicinesError(e.toString()));
    }
  }
}
