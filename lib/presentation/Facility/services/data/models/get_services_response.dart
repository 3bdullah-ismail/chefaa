import 'package:chefaa/presentation/facility/services/data/models/service_model.dart';

class GetServicesResponse {
  final bool? success;
  final String? facilityType;
  final String? aiInsight;
  final List<ServiceModel>? labTests;
  final List<ServiceModel>? radiology;

  GetServicesResponse({
    this.success,
    this.facilityType,
    this.aiInsight,
    this.labTests,
    this.radiology,
  });

  factory GetServicesResponse.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      final data = json['data'];
      List<ServiceModel> parsedLabTests = [];
      List<ServiceModel> parsedRadiology = [];

      if (data is Map<String, dynamic>) {
        if (data['labTests'] is List) {
          parsedLabTests = (data['labTests'] as List)
              .map(
                (item) => ServiceModel.fromJson(item as Map<String, dynamic>),
              )
              .toList();
        }
        if (data['radiology'] is List) {
          parsedRadiology = (data['radiology'] as List)
              .map(
                (item) => ServiceModel.fromJson(item as Map<String, dynamic>),
              )
              .toList();
        }
      }

      return GetServicesResponse(
        success: json['success'] as bool?,
        facilityType: json['facilityType'] as String?,
        aiInsight: json['aiInsight'] as String?,
        labTests: parsedLabTests,
        radiology: parsedRadiology,
      );
    }
    return GetServicesResponse();
  }

  Map<String, dynamic> toJson() {
    return {
      if (success != null) 'success': success,
      if (facilityType != null) 'facilityType': facilityType,
      if (aiInsight != null) 'aiInsight': aiInsight,
      'data': {
        'labTests': labTests?.map((e) => e.toJson()).toList() ?? [],
        'radiology': radiology?.map((e) => e.toJson()).toList() ?? [],
      },
    };
  }
}
