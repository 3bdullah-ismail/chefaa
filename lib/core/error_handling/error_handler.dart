import 'dart:convert';

/// statusMsg : "fail"
/// message : "Account Already Exists"

ErrorHandler errorHandlerFromJson(String str) =>
    ErrorHandler.fromJson(json.decode(str));
String errorHandlerToJson(ErrorHandler data) => json.encode(data.toJson());

class ErrorHandler {
  ErrorHandler({this.statusMsg, this.message});

  ErrorHandler.fromJson(dynamic json) {
    statusMsg = json['statusMsg'];
    message = json['message'];
  }
  String? statusMsg;
  String? message;
  ErrorHandler copyWith({String? statusMsg, String? message}) => ErrorHandler(
    statusMsg: statusMsg ?? this.statusMsg,
    message: message ?? this.message,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusMsg'] = statusMsg;
    map['message'] = message;
    return map;
  }
}
