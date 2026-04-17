import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/search_query.dart';
import '../../data/repositories/search_repo.dart';
import 'search_state.dart';

enum FilterType { filters, specialization, gender, location }

@injectable
class SearchCubit extends Cubit<SearchState> {
  final SearchRepo searchRepo;

  SearchCubit(this.searchRepo) : super(SearchInitial());

  SearchQuery appliedQuery = const SearchQuery();
  SearchQuery draftQuery = const SearchQuery();

  void setSearchText(String value) {
    draftQuery = draftQuery.copyWith(searchText: value);
    emit(SearchDraftChanged(draftQuery));
  }

  Future<void> setSearchTextAndSearch(String value) async {
    setSearchText(value);
    await applySearch();
  }

  void updateFilter({
    String? specialization,
    String? gender,
    String? location,
  }) {
    draftQuery = draftQuery.copyWith(
      specialization: specialization,
      gender: gender,
      location: location,
    );

    emit(SearchDraftChanged(draftQuery));
  }

  Future<void> updateAndSearch({
    String? specialization,
    String? gender,
    String? location,
  }) async {
    updateFilter(
      specialization: specialization,
      gender: gender,
      location: location,
    );

    await applySearch();
  }

  String getFilterValue(FilterType type) {
    switch (type) {
      case FilterType.filters:
        return draftQuery.searchText;
      case FilterType.specialization:
        return draftQuery.specialization;
      case FilterType.gender:
        return draftQuery.gender;
      case FilterType.location:
        return draftQuery.location;
    }
  }

  Future<void> applySearch() async {
    appliedQuery = draftQuery;

    emit(SearchLoading());

    try {
      final result = await searchRepo.filterSearch(
        searchText: appliedQuery.searchText,
        specialization: appliedQuery.specialization,
        gender: appliedQuery.gender,
        location: appliedQuery.location,
      );

      if (result == null) {
        emit(SearchError("No response from server"));
        return;
      }

      emit(SearchSuccess(clinics: result));
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }

  void resetToApplied() {
    draftQuery = appliedQuery;
    emit(SearchDraftChanged(draftQuery));
  }

  void clearFilters() {
    appliedQuery = const SearchQuery();
    draftQuery = const SearchQuery();
    emit(SearchDraftChanged(draftQuery));
  }
}
