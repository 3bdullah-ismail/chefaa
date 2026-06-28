import 'package:chefaa/features/patient/booking/data/models/slots.dart';

sealed class BookingState {}

final class BookingInitialState extends BookingState {}

final class BookingLoadingState extends BookingState {}

final class BookingSuccessState extends BookingState {
  final String? message;

  BookingSuccessState({required this.message});
}

final class BookingErrorState extends BookingState {
  final String error;

  BookingErrorState({required this.error});
}

class GetSlotsLoadingState extends BookingState {}

class GetSlotsSuccessState extends BookingState {
  final List<Slots> slots;

  GetSlotsSuccessState(this.slots);
}

class GetSlotsErrorState extends BookingState {
  final String message;

  GetSlotsErrorState(this.message);
}

class TimeSelectedState extends BookingState {
  final String selectedTime;

  TimeSelectedState(this.selectedTime);
}

final class SlotsErrorState extends BookingState {
  final String error;

  SlotsErrorState({required this.error});
}

class ChangeStepState extends BookingState {}
