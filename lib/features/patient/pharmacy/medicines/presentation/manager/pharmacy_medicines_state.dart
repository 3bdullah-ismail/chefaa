part of 'pharmacy_medicines_cubit.dart';

abstract class PharmacyMedicinesState {}

class PharmacyMedicinesInitial extends PharmacyMedicinesState {}

class PharmacyMedicinesLoading extends PharmacyMedicinesState {}

class PharmacyMedicinesSuccess extends PharmacyMedicinesState {
  final PharmacyMedicinesResponse response;

  PharmacyMedicinesSuccess(this.response);
}

class PharmacyMedicinesFailure extends PharmacyMedicinesState {
  final String message;

  PharmacyMedicinesFailure(this.message);
}
