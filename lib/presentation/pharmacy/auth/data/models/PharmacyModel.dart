import 'Pharmacy.dart';

class PharmacyModel {
  PharmacyModel({
    this.message,
    this.accessToken,
    this.refreshToken,
    this.pharmacy,
  });

  PharmacyModel.fromJson(dynamic json) {
    message = json['message'];
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    pharmacy = json['user'] != null ? Pharmacy.fromJson(json['user']) : null;
  }

  String? message;
  String? accessToken;
  String? refreshToken;
  Pharmacy? pharmacy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['accessToken'] = accessToken;
    map['refreshToken'] = refreshToken;
    if (pharmacy != null) {
      map['user'] = pharmacy?.toJson();
    }
    return map;
  }
}
