part of 'medicine_details_cubit.dart';

abstract class MedicineDetailsState {}

class MedicineDetailsInitial extends MedicineDetailsState {}

class MedicineDetailsLoading extends MedicineDetailsState {}

class MedicineDetailsSuccess extends MedicineDetailsState {
  final MedicineDetailsModel medicineDetails;

  MedicineDetailsSuccess(this.medicineDetails);
}

class MedicineDetailsFailure extends MedicineDetailsState {
  final String message;

  MedicineDetailsFailure(this.message);
}
