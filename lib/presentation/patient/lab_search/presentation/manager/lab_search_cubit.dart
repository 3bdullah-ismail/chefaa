import 'package:chefaa/presentation/patient/lab_search/data/repositories/lab_search_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'lab_search_state.dart';

@injectable
class LabSearchCubit extends Cubit<LabSearchState> {
  final LabSearchRepo _repo;

  LabSearchCubit(this._repo) : super(LabSearchInitial());

  Future<void> searchCenters({
    String? requiredServices,
    bool? homeService,
  }) async {
    emit(LabSearchLoading());
    final result = await _repo.searchCenters(
      requiredServices: requiredServices,
      homeService: homeService,
    );
    result.fold(
      ifLeft: (failure) => emit(LabSearchError(failure.message)),
      ifRight: (response) => emit(LabSearchSuccess(response)),
    );
  }
}
