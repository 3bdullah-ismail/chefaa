
import '../models/data.dart';

abstract class PatientsRepo {
  Future<List<Data>> getPatients();
}