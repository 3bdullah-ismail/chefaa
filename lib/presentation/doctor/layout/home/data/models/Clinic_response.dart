import 'Clinic.dart';

class ClinicResponse {
  ClinicResponse({this.message, this.clinic});

  ClinicResponse.fromJson(dynamic json) {
    message = json['message'];
    clinic = json['clinic'] != null ? Clinic.fromJson(json['clinic']) : null;
  }

  String? message;
  Clinic? clinic;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (clinic != null) {
      map['clinic'] = clinic?.toJson();
    }
    return map;
  }
}
