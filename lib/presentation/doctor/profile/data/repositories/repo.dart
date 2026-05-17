import 'package:chefaa/core/error_handling/failure.dart';
import 'package:chefaa/presentation/doctor/profile/data/models/update_doctor_profile_request.dart';
import 'package:chefaa/presentation/doctor/profile/domain/entities/doctor_profile_entity.dart';
import 'package:dart_either/dart_either.dart';

abstract class DoctorProfileRepo {
  Future<Either<Failure, DoctorProfileEntity>> getDoctorData();

  Future<Either<Failure, DoctorProfileEntity>> upDateDoctorData(
    UpdateDoctorProfileRequest request,
  );
}
