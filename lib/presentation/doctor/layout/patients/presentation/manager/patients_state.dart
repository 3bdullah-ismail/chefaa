import '../../data/models/data.dart';

sealed class PatientsState {}

class PatientsInitialState extends PatientsState {}

class PatientsLoadingState extends PatientsState {}

class PatientsSuccessState extends PatientsState {
  final List<Data> upcoming;
  final List<Data> completed;
  final int selectedIndex;

  PatientsSuccessState({
    required this.upcoming,
    required this.completed,
    this.selectedIndex = 0,
  });

  List<Data> get currentList =>
      selectedIndex == 0 ? upcoming : completed;

  PatientsSuccessState copyWith({
    List<Data>? upcoming,
    List<Data>? completed,
    int? selectedIndex,
  }) {
    return PatientsSuccessState(
      upcoming: upcoming ?? this.upcoming,
      completed: completed ?? this.completed,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}

class PatientsFailureState extends PatientsState {
  final String errorMessage;
  PatientsFailureState(this.errorMessage);
}