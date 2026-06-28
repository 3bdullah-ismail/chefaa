import 'package:chefaa/features/patient/booking/data/models/booking.dart';
import 'package:chefaa/features/patient/booking/data/models/slots.dart';

abstract class BookingRepo {
  Future<List<Slots>> getDaySlots({
    required String clinicId,
    required String date,
  });

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
  });
}
