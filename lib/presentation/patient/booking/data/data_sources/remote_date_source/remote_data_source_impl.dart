import 'package:chefaa/presentation/patient/booking/data/data_sources/remote_date_source/remote_data_source.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../../../core/services/network_service.dart';

@Injectable(as: BookingRemoteDataSource)
class BookingRemoteDataSourceImpl implements BookingRemoteDataSource {
  final NetworkService networkService;

  BookingRemoteDataSourceImpl(this.networkService);

  @override
  Future<Response<dynamic>> getDaySlots({
    required String clinicId,
    required String date,
  }) async {
    try {
      final response = await networkService.dio.get(
        "/clinic/$clinicId/day-slots",
        queryParameters: {"date": date},
      );

      return response;
    } on DioException catch (e) {
      throw e;
    }
  }

  @override
  Future<Response<dynamic>> bookAppointment({
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
    final data = {
      "clinicId": clinicId,
      "date": date,
      "timeChosed": time,
      "isFollowUp": isFollowUp,
      "paymentOption": paymentOption,
      "paymentStatus": paymentStatus,
    };

    if (paymentOption == "prePay" || paymentOption == "online") {
      data.addAll({
        "cardNumber": ?cardNumber,
        "expiryMonth": ?expiryMonth,
        "expiryYear": ?expiryYear,
        "cvv": ?cvv,
        "cardholderName": ?cardholderName,
      });
    }

    return await networkService.dio.post(
      "/appointments/",
      data: data,
    );
  }
}
