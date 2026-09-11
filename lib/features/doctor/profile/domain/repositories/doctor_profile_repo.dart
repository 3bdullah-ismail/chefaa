import 'package:chefaa/core/imports/imports.dart';
import 'package:chefaa/core/error_handling/failure.dart';
import 'package:chefaa/features/doctor/profile/domain/entities/doctor_profile_entity.dart';

abstract class DoctorProfileRepo {
  Future<Either<Failure, DoctorProfileEntity>> getDoctorData();

  Future<Either<Failure, DoctorProfileEntity>> upDateDoctorData(
    DoctorProfileEntity request,
  );
}
