import 'package:chefaa/presentation/patient/booking/data/models/Booking.dart';
import 'package:chefaa/presentation/patient/booking/data/models/Slots.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/error_handling/failure.dart';
import '../data_sources/remote_date_source/remote_data_source.dart';
import 'booking_repo.dart';

@Injectable(as: BookingRepo)
class BookingRepoImp implements BookingRepo {
  final BookingRemoteDataSource remoteDataSource;

  BookingRepoImp(this.remoteDataSource);


  @override
  Future<Booking> bookAppointment({
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
  }) async {
    try {
      final response = await remoteDataSource.bookAppointment(
        clinicId: clinicId,
        date: date,
        time: time,
        isFollowUp: isFollowUp,
        paymentOption: paymentOption,
        paymentStatus: paymentStatus,
        cardNumber: cardNumber,
        expiryMonth: expiryMonth,
        expiryYear: expiryYear,
        cvv: cvv,
        cardholderName: cardholderName,
      );

      return Booking.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<List<Slots>> getDaySlots({
    required String clinicId,
    required String date,
  }) async {
    try {
      final response = await remoteDataSource.getDaySlots(
        clinicId: clinicId,
        date: date,
      );

      return (response.data['slots'] as List)
          .map((slot) => Slots.fromJson(slot))
          .toList();
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e);
    } catch (_) {
      throw ServerFailure.unexpectedError;
    }
  }
}
