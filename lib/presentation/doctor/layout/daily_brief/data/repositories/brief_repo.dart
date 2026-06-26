import 'package:chefaa/presentation/doctor/layout/daily_brief/data/models/Brief.dart';
import 'package:chefaa/presentation/doctor/layout/daily_brief/data/models/Financials.dart';

abstract class BriefRepo {
  Future<Brief> getDailyBrief({required String language});
  Future<Financials> getFinancialsReport({required String language});
}