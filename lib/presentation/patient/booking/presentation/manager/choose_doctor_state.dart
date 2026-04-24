import '../widgets/doctor_model.dart';

enum DoctorFilterType { navigation, menu }

class DoctorFilterItem {
  final String title;
  final DoctorFilterType type;

  const DoctorFilterItem({required this.title, required this.type});
}

class ChooseDoctorState {
  final String searchQuery;
  final String? selectedSpecialty;
  final String? selectedGender;
  final String? selectedLocation;
  final List<DoctorModel> filteredDoctors;

  const ChooseDoctorState({
    this.searchQuery = '',
    this.selectedSpecialty,
    this.selectedGender,
    this.selectedLocation,
    required this.filteredDoctors,
  });

  factory ChooseDoctorState.initial(List<DoctorModel> doctors) {
    return ChooseDoctorState(filteredDoctors: doctors);
  }

  ChooseDoctorState copyWith({
    String? searchQuery,
    String? selectedSpecialty,
    String? selectedGender,
    String? selectedLocation,
    List<DoctorModel>? filteredDoctors,
  }) {
    return ChooseDoctorState(
      searchQuery: searchQuery ?? this.searchQuery,
      selectedSpecialty: selectedSpecialty ?? this.selectedSpecialty,
      selectedGender: selectedGender ?? this.selectedGender,
      selectedLocation: selectedLocation ?? this.selectedLocation,
      filteredDoctors: filteredDoctors ?? this.filteredDoctors,
    );
  }
}

