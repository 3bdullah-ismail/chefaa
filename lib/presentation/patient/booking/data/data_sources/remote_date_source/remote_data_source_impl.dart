import 'package:chefaa/presentation/patient/booking/data/data_sources/remote_date_source/remote_data_source.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/services/network_service.dart';

@Injectable(as: BookingRemoteDataSource)
class BookingRemoteDataSourceImpl implements BookingRemoteDataSource {
  NetworkService networkService;

  BookingRemoteDataSourceImpl(this.networkService);

  @override
  Future<String> bookAppointment({
    required String doctorId,
    required String patientId,
    required DateTime dateTime,
  }) {
    // TODO: implement bookAppointment
    throw UnimplementedError();
  }

  @override
  Future<Response<dynamic>> getAvailableTimes({required String date}) {
    return networkService.dio.get(
      "appointments/available-times",
      queryParameters: {"date": date},
    );
  }
}
