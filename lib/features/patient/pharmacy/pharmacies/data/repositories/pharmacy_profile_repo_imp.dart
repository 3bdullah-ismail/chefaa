import 'package:dart_either/dart_either.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:chefaa/core/error_handling/failure.dart';
import 'package:chefaa/features/patient/pharmacy/pharmacies/domain/repositories/pharmacy_profile_repo.dart';
import 'package:chefaa/features/patient/pharmacy/pharmacies/data/data_sources/pharmacy_remote_data_source.dart';
import 'package:chefaa/features/patient/pharmacy/pharmacies/data/models/pharmacy_profile_model.dart';
import 'package:chefaa/features/patient/pharmacy/pharmacies/data/models/search_pharmacies_response.dart';
import 'package:chefaa/features/patient/pharmacy/pharmacies/data/models/pharmacy_medicines_response.dart';
import 'package:chefaa/features/patient/pharmacy/medicines/data/models/medicine_details_model.dart';
import 'package:chefaa/features/patient/pharmacy/pharmacies/data/models/checkout_response.dart';

@Injectable(as: PharmacyProfileRepo)
class PharmacyProfileRepoImp implements PharmacyProfileRepo {
  final PharmacyRemoteDataSource remoteDataSource;

  PharmacyProfileRepoImp(this.remoteDataSource);

  @override
  Future<Either<Failure, PharmacyProfileModel>> getPharmacyProfile(String pharmacyId) async {
    try {
      final response = await remoteDataSource.getPharmacyProfile(pharmacyId);
      final model = PharmacyProfileModel.fromJson(response.data['data']);
      return Right(model);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SearchPharmaciesResponse>> searchPharmacies(String query) async {
    try {
      final response = await remoteDataSource.searchPharmacies(query);
      final model = SearchPharmaciesResponse.fromJson(response.data);
      return Right(model);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PharmacyMedicinesResponse>> getPharmacyMedicines(String pharmacyId) async {
    try {
      final response = await remoteDataSource.getPharmacyMedicines(pharmacyId);
      final model = PharmacyMedicinesResponse.fromJson(response.data);
      return Right(model);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, MedicineDetailsModel>> getMedicineDetails(String medicineId) async {
    try {
      final response = await remoteDataSource.getMedicineDetails(medicineId);
      final model = MedicineDetailsModel.fromJson(response.data['data']);
      return Right(model);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addPharmacyReview(
    String pharmacyId,
    int rating,
    String comment,
  ) async {
    try {
      await remoteDataSource.addPharmacyReview(pharmacyId, rating, comment);
      return const Right(null);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CheckoutResponse>> checkoutOrder(
    Map<String, dynamic> checkoutData,
  ) async {
    try {
      final response = await remoteDataSource.checkoutOrder(checkoutData);
      final model = CheckoutResponse.fromJson(response.data);
      return Right(model);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
