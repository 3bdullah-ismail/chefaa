part of 'track_order_cubit.dart';

abstract class TrackOrderState {}

class TrackOrderInitial extends TrackOrderState {}

class TrackOrderLoading extends TrackOrderState {}

class TrackOrderSuccess extends TrackOrderState {
  final TrackOrderResponse response;

  TrackOrderSuccess(this.response);
}

class TrackOrderFailure extends TrackOrderState {
  final String message;

  TrackOrderFailure(this.message);
}

class ConfirmReceiptLoading extends TrackOrderState {}

class ConfirmReceiptSuccess extends TrackOrderState {
  final ConfirmReceiptResponse response;

  ConfirmReceiptSuccess(this.response);
}

class ConfirmReceiptFailure extends TrackOrderState {
  final String message;

  ConfirmReceiptFailure(this.message);
}
