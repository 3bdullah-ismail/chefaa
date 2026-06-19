import 'package:chefaa/presentation/patient/booking/data/models/Booking.dart';
import 'package:chefaa/presentation/patient/booking/data/models/Slots.dart';


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