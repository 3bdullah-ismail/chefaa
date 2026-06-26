import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../data/repositories/pharmacy_inventory_repo.dart';
import '../../data/models/add_medicine_response.dart';
import '../../data/models/get_medicines_response.dart';
import '../../data/models/get_low_stock_response.dart';

part 'pharmacy_inventory_state.dart';

@injectable
class PharmacyInventoryCubit extends Cubit<PharmacyInventoryState> {
  final PharmacyInventoryRepo pharmacyInventoryRepo;

  PharmacyInventoryCubit(this.pharmacyInventoryRepo)
      : super(PharmacyInventoryInitial());

  Future<void> addMedicine(Map<String, dynamic> body) async {
    emit(AddMedicineLoading());
    try {
      final response = await pharmacyInventoryRepo.addMedicine(body);
      emit(AddMedicineSuccess(response));
    } catch (e) {
      emit(AddMedicineError(e.toString()));
    }
  }

  Future<void> getMedicines({String? search, String? filter}) async {
    emit(GetMedicinesLoading());
    try {
      if (search != null && search.trim().isNotEmpty) {
        final response = await pharmacyInventoryRepo.searchMedicines(search.trim());
        emit(GetMedicinesSuccess(response));
      } else if (filter == "low") {
        final response = await pharmacyInventoryRepo.getLowStock(
          search: search,
        );
        emit(GetLowStockSuccess(response));
      } else {
        final response = await pharmacyInventoryRepo.getMedicines(
          search: search,
          filter: filter,
        );
        emit(GetMedicinesSuccess(response));
      }
    } catch (e) {
      emit(GetMedicinesError(e.toString()));
    }
  }
}
