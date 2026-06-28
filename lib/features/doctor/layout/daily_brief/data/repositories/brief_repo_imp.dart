import 'package:chefaa/features/doctor/layout/daily_brief/data/data_sources/brief_data_source.dart';
import 'package:chefaa/features/doctor/layout/daily_brief/data/models/brief.dart';
import 'package:chefaa/features/doctor/layout/daily_brief/data/models/financials.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:chefaa/core/error_handling/failure.dart';
import 'package:chefaa/features/doctor/layout/daily_brief/domain/repositories/brief_repo.dart';

@Injectable(as: BriefRepo)
class BriefRepoImp implements BriefRepo {
  BriefDataSource briefDataSource;

  BriefRepoImp({required this.briefDataSource});

  @override
  Future<Brief> getDailyBrief({required String language}) async {
    try {
      final response = await briefDataSource.getDailyBrief(language: language);
      if (response.statusCode == 200) {
        return Brief.fromJson(response.data);
      } else {
        throw Exception('Failed to load daily brief');
      }
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e).message;
    } catch (e) {
      throw ServerFailure.unexpectedError;
    }
  }

  @override
  Future<Financials> getFinancialsReport({required String language}) async {
    try {
      final response = await briefDataSource.getFinancialsReport(
        language: language,
      );
      if (response.statusCode == 200) {
        return Financials.fromJson(response.data);
      } else {
        throw Exception('Failed to load financials report');
      }
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e).message;
    } catch (e) {
      throw ServerFailure.unexpectedError;
    }
  }
}

