import 'patient.dart';

class CompletePatientDataResponse {
  CompletePatientDataResponse({this.message, this.patient});

  CompletePatientDataResponse.fromJson(dynamic json) {
    if (json is! Map<String, dynamic>) throw const FormatException('Invalid JSON');
    message = json['message'];
    patient = json['patient'] != null
        ? Patient.fromJson(json['patient'])
        : null;
  }

  String? message;
  Patient? patient;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (patient != null) {
      map['patient'] = patient?.toJson();
    }
    return map;
  }
}

