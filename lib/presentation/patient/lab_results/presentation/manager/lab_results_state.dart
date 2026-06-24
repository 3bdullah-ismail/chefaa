import '../../data/models/lab_results_response.dart';

abstract class LabResultsState {}

class LabResultsInitialState extends LabResultsState {}

class LabResultsLoadingState extends LabResultsState {}

class LabResultsSuccessState extends LabResultsState {
  final List<LabResultItem> results;

  LabResultsSuccessState({required this.results});
}

class LabResultsErrorState extends LabResultsState {
  final String errorMessage;

  LabResultsErrorState({required this.errorMessage});
}
