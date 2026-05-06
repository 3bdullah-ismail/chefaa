import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/search_query.dart';
import '../../data/repositories/search_repo.dart';
import '../../domain/entities/doctor_model.dart';

part 'search_state.dart';

enum FilterType { filters, specialization, gender, location }

@injectable
class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.searchRepo) : super(SearchInitial()) {
    searchController.addListener(_handleSearchChanged);
  }

  final SearchRepo searchRepo;
  final TextEditingController searchController = TextEditingController();

  SearchQuery appliedQuery = const SearchQuery();
  SearchQuery draftQuery = const SearchQuery();
  bool _isSearching = false;

  // Keep latest result so list widgets can render through transitions.
  List<DoctorModel> _lastClinics = const [];

  List<DoctorModel> get lastClinics => _lastClinics;

  final List<FilterType> filterTabs = const [
    FilterType.filters,
    FilterType.specialization,
    FilterType.gender,
    FilterType.location,
  ];

  void _handleSearchChanged() {
    setSearchText(searchController.text);
  }

  void setSearchText(String value) {
    if (draftQuery.searchText == value) return;

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

  bool hasActiveSelections() {
    return draftQuery.searchText.trim().isNotEmpty ||
        draftQuery.specialization.trim().isNotEmpty ||
        draftQuery.gender.trim().isNotEmpty ||
        draftQuery.location.trim().isNotEmpty;
  }

  bool isChipSelected(FilterType type) {
    if (type == FilterType.filters) return hasActiveSelections();
    return getFilterValue(type).trim().isNotEmpty;
  }

  String labelFor(FilterType type) {
    switch (type) {
      case FilterType.filters:
        return hasActiveSelections() ? 'Clear' : 'Filters';
      case FilterType.specialization:
        return draftQuery.specialization.isNotEmpty
            ? draftQuery.specialization
            : 'Specialty';
      case FilterType.gender:
        if (draftQuery.gender.isEmpty) return 'Gender';
        return _capitalize(draftQuery.gender);
      case FilterType.location:
        return draftQuery.location.isNotEmpty
            ? draftQuery.location
            : 'Location';
    }
  }

  Future<void> applySearch() async {
    if (_isSearching) return;
    _isSearching = true;
    appliedQuery = draftQuery;

    emit(SearchLoading(isRefreshing: _lastClinics.isNotEmpty));

    try {
      final result = await searchRepo.filterSearch(
        searchText: appliedQuery.searchText,
        specialization: appliedQuery.specialization,
        gender: appliedQuery.gender,
        location: appliedQuery.location,
      );

      if (result == null) {
        emit(SearchError('No response from server'));
        return;
      }

      _lastClinics = result;
      emit(SearchSuccess(clinics: result));
    } catch (e) {
      emit(SearchError(e.toString()));
    } finally {
      _isSearching = false;
    }
  }

  void resetToApplied() {
    draftQuery = appliedQuery;
    searchController.text = appliedQuery.searchText;
    emit(SearchDraftChanged(draftQuery));
  }

  void clearFilters() {
    appliedQuery = const SearchQuery();
    draftQuery = const SearchQuery();
    searchController.text = '';
    emit(SearchDraftChanged(draftQuery));
  }

  String _capitalize(String value) {
    if (value.isEmpty) return value;
    return value[0].toUpperCase() + value.substring(1).toLowerCase();
  }

  @override
  Future<void> close() {
    searchController.removeListener(_handleSearchChanged);
    searchController.dispose();
    return super.close();
  }
}
