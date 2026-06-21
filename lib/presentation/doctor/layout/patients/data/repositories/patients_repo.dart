
import '../models/Data.dart';

abstract class PatientsRepo {
  Future<List<Data>> getPatients();
}