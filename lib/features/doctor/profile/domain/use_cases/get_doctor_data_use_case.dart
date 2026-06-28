import 'package:chefaa/core/error_handling/failure.dart';
import 'package:chefaa/features/doctor/profile/domain/entities/doctor_profile_entity.dart';
import 'package:chefaa/features/doctor/profile/domain/repositories/doctor_profile_repo.dart';
import 'package:dart_either/dart_either.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetDoctorDataUseCase {
  final DoctorProfileRepo repository;

  GetDoctorDataUseCase(this.repository);

  Future<Either<Failure, DoctorProfileEntity>> call() {
    return repository.getDoctorData();
  }
}
