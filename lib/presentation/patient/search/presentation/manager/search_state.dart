import 'package:chefaa/presentation/patient/search/data/models/search_query.dart';
import 'package:chefaa/presentation/patient/search/domain/entities/clinic_model.dart';

sealed class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {
  final bool isRefreshing;

  SearchLoading({this.isRefreshing = false});
}

class SearchSuccess extends SearchState {
  final List<ClinicModel> clinics;
  final bool isFromCache;
  final bool isRefreshing;

  SearchSuccess({
    required this.clinics,
    this.isFromCache = false,
    this.isRefreshing = false,
  });
}

class SearchError extends SearchState {
  final String message;

  SearchError(this.message);
}

final class SearchDraftChanged extends SearchState {
  final SearchQuery draftQuery;

  SearchDraftChanged(this.draftQuery);
}
