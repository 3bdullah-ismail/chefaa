part of 'pharmacy_inventory_cubit.dart';

sealed class PharmacyInventoryState {}

final class PharmacyInventoryInitial extends PharmacyInventoryState {}

final class AddMedicineLoading extends PharmacyInventoryState {}

final class AddMedicineSuccess extends PharmacyInventoryState {
  final AddMedicineResponse response;

  AddMedicineSuccess(this.response);
}

final class AddMedicineError extends PharmacyInventoryState {
  final String errorMessage;

  AddMedicineError(this.errorMessage);
}

final class GetMedicinesLoading extends PharmacyInventoryState {}

final class GetMedicinesSuccess extends PharmacyInventoryState {
  final GetMedicinesResponse response;

  GetMedicinesSuccess(this.response);
}

final class GetMedicinesError extends PharmacyInventoryState {
  final String errorMessage;

  GetMedicinesError(this.errorMessage);
}

final class GetLowStockSuccess extends PharmacyInventoryState {
  final GetLowStockResponse response;

  GetLowStockSuccess(this.response);
}
