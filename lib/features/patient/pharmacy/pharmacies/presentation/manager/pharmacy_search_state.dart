part of 'pharmacy_search_cubit.dart';

abstract class PharmacySearchState {}

class PharmacySearchInitial extends PharmacySearchState {}

class PharmacySearchLoading extends PharmacySearchState {}

class PharmacySearchSuccess extends PharmacySearchState {
  final SearchPharmaciesResponse response;
  PharmacySearchSuccess(this.response);
}

class PharmacySearchFailure extends PharmacySearchState {
  final String message;
  PharmacySearchFailure(this.message);
}

