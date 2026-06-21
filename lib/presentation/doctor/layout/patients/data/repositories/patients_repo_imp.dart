import 'package:chefaa/presentation/doctor/layout/patients/data/data_sources/patients_data_sourse.dart';
import 'package:chefaa/presentation/doctor/layout/patients/data/repositories/patients_repo.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/error_handling/failure.dart';
import '../models/Data.dart';

@Injectable(as: PatientsRepo)
class PatientsRepoImp implements PatientsRepo{
  PatientsDataSource patientsDataSource;
  PatientsRepoImp(this.patientsDataSource);
  @override
  Future<List<Data>> getPatients() async {
    try {
      final response = await patientsDataSource.getPatients();

      final List dataList = response.data['data'];

      return dataList
          .map((e) => Data.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e).message;
    } catch (e) {
      throw ServerFailure.unexpectedError;
    }
  }}