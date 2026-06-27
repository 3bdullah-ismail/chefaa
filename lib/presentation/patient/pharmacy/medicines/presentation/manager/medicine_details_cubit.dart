import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/medicine_details_model.dart';
import '../../../pharmacies/domain/repositories/pharmacy_profile_repo.dart';

part 'medicine_details_state.dart';

@injectable
class MedicineDetailsCubit extends Cubit<MedicineDetailsState> {
  final PharmacyProfileRepo pharmacyProfileRepo;

  MedicineDetailsCubit(this.pharmacyProfileRepo)
      : super(MedicineDetailsInitial());

  Future<void> getMedicineDetails(String medicineId) async {
    emit(MedicineDetailsLoading());

    final result = await pharmacyProfileRepo.getMedicineDetails(medicineId);

    result.fold(
      ifLeft: (failure) => emit(MedicineDetailsFailure(failure.message)),
      ifRight: (details) => emit(MedicineDetailsSuccess(details)),
    );
  }
}
