part of "search_cubit.dart";

sealed class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<DoctorModel> clinics;

  SearchSuccess({required this.clinics});
}

class SearchError extends SearchState {
  final String message;

  SearchError(this.message);
}

final class SearchDraftChanged extends SearchState {
  final SearchQuery draftQuery;

  SearchDraftChanged(this.draftQuery);
}
