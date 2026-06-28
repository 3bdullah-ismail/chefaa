part of 'services_cubit.dart';

@immutable
sealed class ServicesState {}

final class ServicesInitial extends ServicesState {}

final class AddServiceLoading extends ServicesState {}

final class AddServiceSuccess extends ServicesState {
  final ServiceModel service;

  AddServiceSuccess(this.service);
}

final class AddServiceFailure extends ServicesState {
  final String errorMessage;

  AddServiceFailure(this.errorMessage);
}

final class GetServicesLoading extends ServicesState {}

final class GetServicesSuccess extends ServicesState {
  final GetServicesResponse response;

  GetServicesSuccess(this.response);
}

final class GetServicesFailure extends ServicesState {
  final String errorMessage;

  GetServicesFailure(this.errorMessage);
}

final class ToggleServiceLoading extends ServicesState {}

final class ToggleServiceSuccess extends ServicesState {
  final ServiceModel service;

  ToggleServiceSuccess(this.service);
}

final class ToggleServiceFailure extends ServicesState {
  final String errorMessage;

  ToggleServiceFailure(this.errorMessage);
}
