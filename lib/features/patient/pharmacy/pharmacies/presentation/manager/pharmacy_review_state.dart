part of 'pharmacy_review_cubit.dart';

abstract class PharmacyReviewState {}

class PharmacyReviewInitial extends PharmacyReviewState {}

class PharmacyReviewLoading extends PharmacyReviewState {}

class PharmacyReviewSuccess extends PharmacyReviewState {}

class PharmacyReviewFailure extends PharmacyReviewState {
  final String message;

  PharmacyReviewFailure(this.message);
}
