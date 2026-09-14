import 'package:chefaa/core/imports/imports.dart';

abstract class BriefDataSource {
  Future<Response> getDailyBrief({required String language});
  Future<Response> getFinancialsReport({required String language});
}
