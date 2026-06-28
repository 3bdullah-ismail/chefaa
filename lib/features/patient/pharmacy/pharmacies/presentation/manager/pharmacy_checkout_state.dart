part of 'pharmacy_checkout_cubit.dart';

abstract class PharmacyCheckoutState {}

class PharmacyCheckoutInitial extends PharmacyCheckoutState {}

class PharmacyCheckoutLoading extends PharmacyCheckoutState {}

class PharmacyCheckoutSuccess extends PharmacyCheckoutState {
  final CheckoutResponse response;

  PharmacyCheckoutSuccess(this.response);
}

class PharmacyCheckoutFailure extends PharmacyCheckoutState {
  final String message;

  PharmacyCheckoutFailure(this.message);
}
