part of 'payment_cubit.dart';

abstract class PaymentState {}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentSuccess extends PaymentState {
  final OnlinePaymentResponse response;

  PaymentSuccess(this.response);
}

class PaymentFailure extends PaymentState {
  final String message;

  PaymentFailure(this.message);
}
