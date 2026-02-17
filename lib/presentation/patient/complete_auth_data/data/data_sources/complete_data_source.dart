import 'package:dio/dio.dart';

abstract class CompleteDataSource {
  Future<Response> completeSignUp({
    required double? weight,
    required int? height,
    required String? bloodType,
    required String? gender,
    required int? age,
    required List<String>? chronicDiseases,
    required List<String>? allergies,
  });
}
