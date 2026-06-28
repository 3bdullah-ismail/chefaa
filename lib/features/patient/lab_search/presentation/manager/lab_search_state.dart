import 'package:chefaa/features/patient/lab_search/data/models/search_centers_response.dart';

sealed class LabSearchState {}

final class LabSearchInitial extends LabSearchState {}

final class LabSearchLoading extends LabSearchState {}

final class LabSearchSuccess extends LabSearchState {
  final SearchCentersResponse response;

  LabSearchSuccess(this.response);
}

final class LabSearchError extends LabSearchState {
  final String error;

  LabSearchError(this.error);
}
