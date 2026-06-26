import 'package:dart_either/dart_either.dart';
import '../../../../../../core/error_handling/failure.dart';
import '../../data/models/pharmacy_profile_model.dart';

abstract class PharmacyProfileRepo {
  Future<Either<Failure, PharmacyProfileModel>> getPharmacyProfile(
    String pharmacyId,
  );
}
