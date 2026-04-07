import 'dart:convert';

ApiErrorModel apiErrorModelFromJson(String str) =>
    ApiErrorModel.fromJson(json.decode(str));

String apiErrorModelToJson(ApiErrorModel data) => json.encode(data.toJson());

class ApiErrorModel {
  String? statusMsg;
  String? message;

  ApiErrorModel({this.statusMsg, this.message});

  ApiErrorModel.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      statusMsg = json['statusMsg']?.toString();
      message = json['message']?.toString();
    } else {
      statusMsg = "Error";
      message = "Something went wrong.";
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusMsg'] = statusMsg;
    map['message'] = message;
    return map;
  }
}
