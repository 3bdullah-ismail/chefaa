import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repositories/pharmacy_profile_repo.dart';

part 'pharmacy_review_state.dart';

@injectable
class PharmacyReviewCubit extends Cubit<PharmacyReviewState> {
  final PharmacyProfileRepo pharmacyProfileRepo;

  PharmacyReviewCubit(this.pharmacyProfileRepo)
      : super(PharmacyReviewInitial());

  Future<void> addPharmacyReview(
    String pharmacyId,
    int rating,
    String comment,
  ) async {
    emit(PharmacyReviewLoading());

    final result =
        await pharmacyProfileRepo.addPharmacyReview(pharmacyId, rating, comment);

    result.fold(
      ifLeft: (failure) => emit(PharmacyReviewFailure(failure.message)),
      ifRight: (_) => emit(PharmacyReviewSuccess()),
    );
  }
}
