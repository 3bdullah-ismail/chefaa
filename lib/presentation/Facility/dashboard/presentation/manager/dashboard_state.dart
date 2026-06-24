part of 'dashboard_cubit.dart';

@immutable
sealed class DashboardState {}

final class DashboardInitial extends DashboardState {}

// Get Dashboard States
final class GetDashboardLoading extends DashboardState {}

final class GetDashboardSuccess extends DashboardState {
  final GetDashboardResponse response;

  GetDashboardSuccess(this.response);
}

final class GetDashboardFailure extends DashboardState {
  final String errorMessage;

  GetDashboardFailure(this.errorMessage);
}

// Upload Result States
final class UploadResultLoading extends DashboardState {
  final String? requestId;

  UploadResultLoading({this.requestId});
}

final class UploadResultSuccess extends DashboardState {
  final UploadResultResponse response;

  UploadResultSuccess(this.response);
}

final class UploadResultFailure extends DashboardState {
  final String errorMessage;

  UploadResultFailure(this.errorMessage);
}

// Create Patient Request States
final class CreatePatientRequestLoading extends DashboardState {}

final class CreatePatientRequestSuccess extends DashboardState {
  final CreatePatientRequestResponse response;

  CreatePatientRequestSuccess(this.response);
}

final class CreatePatientRequestFailure extends DashboardState {
  final String errorMessage;

  CreatePatientRequestFailure(this.errorMessage);
}
