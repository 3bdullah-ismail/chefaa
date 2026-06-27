import 'Data.dart';

class AppointmentResponse {
  AppointmentResponse({
      this.success, 
      this.count, 
      this.data,});

  AppointmentResponse.fromJson(dynamic json) {
    success = json['success'];
    count = json['count'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(AppointmentModel.fromJson(v));
      });
    }
  }
  bool? success;
  num? count;
  List<AppointmentModel>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['count'] = count;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}