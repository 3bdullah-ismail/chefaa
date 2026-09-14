import 'package:chefaa/core/imports/imports.dart';

abstract class CompleteDataSource {
  Future<Response> completeSignUp({
    required double? weight,
    required int? height,
    required String? bloodType,
    required String? gender,
    required int? age,
    required List<String>? chronicConditions,
    required List<String>? allergies,
  });
}
