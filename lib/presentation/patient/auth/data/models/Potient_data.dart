import 'patient.dart';

class PatientData {
  PatientData({
      this.message, 
      this.accessToken, 
      this.refreshToken, 
      this.patient,});

  PatientData.fromJson(dynamic json) {
    message = json['message'];
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    patient = json['user'] != null ? Patient.fromJson(json['user']) : null;
  }
  String? message;
  String? accessToken;
  String? refreshToken;
  Patient? patient;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['accessToken'] = accessToken;
    map['refreshToken'] = refreshToken;
    if (patient != null) {
      map['user'] = patient?.toJson();
    }
    return map;
  }

}