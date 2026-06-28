import 'package:chefaa/features/doctor/layout/daily_brief/data/models/brief.dart';
import 'package:chefaa/features/doctor/layout/daily_brief/data/models/financials.dart';

abstract class BriefRepo {
  Future<Brief> getDailyBrief({required String language});
  Future<Financials> getFinancialsReport({required String language});
}
