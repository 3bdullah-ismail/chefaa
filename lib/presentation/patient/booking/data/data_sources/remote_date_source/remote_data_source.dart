import 'package:dio/dio.dart';

abstract class BookingRemoteDataSource {
  Future<Response> getDaySlots({
    required String clinicId,
    required String date,
  });

  Future<Response> bookAppointment({
    required String clinicId,
    required String date,
    required String time,
    required bool isFollowUp,
    required String paymentOption,
    required String paymentStatus,
    String? cardNumber,
    String? expiryMonth,
    String? expiryYear,
    String? cvv,
    String? cardholderName,
  });
}
