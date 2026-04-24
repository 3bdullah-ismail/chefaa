import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/doctor_model.dart';
import 'choose_doctor_state.dart';

class _DoctorEntry {
  final DoctorModel doctor;
  final String gender;
  final String location;

  const _DoctorEntry({
    required this.doctor,
    required this.gender,
    required this.location,
  });
}

class ChooseDoctorCubit extends Cubit<ChooseDoctorState> {
  ChooseDoctorCubit()
      : super(ChooseDoctorState.initial(_sampleDoctors)) {
    searchController.addListener(_handleSearchChanged);
  }

  static final List<_DoctorEntry> _sampleEntries = [
    _DoctorEntry(
      doctor: DoctorModel(
        name: 'DR. Ahmed Ali',
        specialty: 'Internal Medicine Specialist',
        rating: '4.8',
        price: '145',
        ratingCount: '150',
        availableDays: [
          DateTime.now(),
          DateTime.now().add(const Duration(days: 2)),
          DateTime.now().add(const Duration(days: 5)),
        ],
      ),
      gender: 'Male',
      location: 'Nearby',
    ),
    _DoctorEntry(
      doctor: DoctorModel(
        name: 'DR. Abdallah Zalabia',
        specialty: 'Ophthalmology Specialist',
        rating: '4.9',
        price: '150',
        ratingCount: '1700',
        availableDays: [
          DateTime.now(),
          DateTime.now().add(const Duration(days: 2)),
          DateTime.now().add(const Duration(days: 5)),
        ],
      ),
      gender: 'Male',
      location: 'Downtown',
    ),
    _DoctorEntry(
      doctor: DoctorModel(
        name: 'DR. Sara Mahmoud',
        specialty: 'Pediatrics Specialist',
        rating: '4.7',
        price: '180',
        ratingCount: '320',
        availableDays: [
          DateTime.now(),
          DateTime.now().add(const Duration(days: 1)),
          DateTime.now().add(const Duration(days: 4)),
        ],
      ),
      gender: 'Female',
      location: 'Nearby',
    ),
  ];

  static final List<DoctorModel> _sampleDoctors =
      _sampleEntries.map((entry) => entry.doctor).toList();

  final TextEditingController searchController = TextEditingController();

  final List<DoctorFilterItem> filterTabs = const [
    DoctorFilterItem(title: 'Filters', type: DoctorFilterType.navigation),
    DoctorFilterItem(title: 'Specialty', type: DoctorFilterType.navigation),
    DoctorFilterItem(title: 'Gender', type: DoctorFilterType.menu),
    DoctorFilterItem(title: 'Location', type: DoctorFilterType.navigation),
  ];

  void _handleSearchChanged() {
    setSearchText(searchController.text);
  }

  void setSearchText(String value) {
    final nextState = state.copyWith(searchQuery: value);
    emit(_applyFilters(nextState));
  }

  void setSpecialty(String value) {
    emit(
      _applyFilters(
        state.copyWith(selectedSpecialty: value),
      ),
    );
  }

  void setGender(String value) {
    emit(
      _applyFilters(
        state.copyWith(selectedGender: value),
      ),
    );
  }

  void setLocation(String value) {
    emit(
      _applyFilters(
        state.copyWith(selectedLocation: value),
      ),
    );
  }

  void clearFilters() {
    emit(ChooseDoctorState.initial(_sampleDoctors));
    searchController.clear();
  }

  bool hasActiveSelections(ChooseDoctorState state) {
    return state.searchQuery.trim().isNotEmpty ||
        state.selectedSpecialty != null ||
        state.selectedGender != null ||
        state.selectedLocation != null;
  }

  bool isSelected(DoctorFilterItem item, ChooseDoctorState state) {
    switch (item.title) {
      case 'Filters':
        return false;
      case 'Specialty':
        return state.selectedSpecialty != null;
      case 'Gender':
        return state.selectedGender != null;
      case 'Location':
        return state.selectedLocation != null;
      default:
        return false;
    }
  }

  String labelFor(DoctorFilterItem item, ChooseDoctorState state) {
    switch (item.title) {
      case 'Filters':
        return  item.title;
      case 'Specialty':
        return state.selectedSpecialty ?? item.title;
      case 'Gender':
        return state.selectedGender ?? item.title;
      case 'Location':
        return state.selectedLocation ?? item.title;
      default:
        return item.title;
    }
  }

  ChooseDoctorState _applyFilters(ChooseDoctorState nextState) {
    final query = nextState.searchQuery.trim().toLowerCase();
    final specialty = nextState.selectedSpecialty?.trim().toLowerCase();
    final gender = nextState.selectedGender?.trim().toLowerCase();
    final location = nextState.selectedLocation?.trim().toLowerCase();

    final filteredDoctors = _sampleEntries.where((entry) {
      final doctor = entry.doctor;
      final matchesSearch = query.isEmpty ||
          doctor.name.toLowerCase().contains(query) ||
          doctor.specialty.toLowerCase().contains(query);

      final matchesSpecialty = specialty == null ||
          doctor.specialty.toLowerCase().contains(specialty);

      final matchesGender = gender == null || entry.gender.toLowerCase() == gender;

      final matchesLocation = location == null || entry.location.toLowerCase() == location;

      return matchesSearch &&
          matchesSpecialty &&
          matchesGender &&
          matchesLocation;
    }).map((entry) => entry.doctor).toList();

    return nextState.copyWith(filteredDoctors: filteredDoctors);
  }

  @override
  Future<void> close() {
    searchController.removeListener(_handleSearchChanged);
    searchController.dispose();
    return super.close();
  }
}

