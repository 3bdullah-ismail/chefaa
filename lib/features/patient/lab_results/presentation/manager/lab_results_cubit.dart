import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:chefaa/features/patient/lab_results/domain/repositories/lab_results_repository.dart';
import 'lab_results_state.dart';

@injectable
class LabResultsCubit extends Cubit<LabResultsState> {
  final LabResultsRepository _repository;

  LabResultsCubit(this._repository) : super(LabResultsInitialState());

  static LabResultsCubit get(BuildContext context) =>
      BlocProvider.of<LabResultsCubit>(context);

  Future<void> getLabResults() async {
      if (!isClosed) emit(LabResultsLoadingState());
    try {
      final response = await _repository.getLabResults();
      final results = response.results ?? [];
      if (!isClosed) emit(LabResultsSuccessState(results: results));
    } catch (e) {
      if (!isClosed) emit(LabResultsErrorState(errorMessage: e.toString()));
    }
  }
}
