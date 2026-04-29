import 'Data.dart';

class ReportAnalysis {
  String? message;
  String? error;
  bool? success;
  Data? data;

  ReportAnalysis({this.message, this.error, this.success, this.data});

  factory ReportAnalysis.fromJson(Map<String, dynamic> json) {
    return ReportAnalysis(
      message: json['message'],
      error: json['error'],
      success: json['success'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'error': error,
      'success': success,
      'data': data?.toJson(),
    };
  }
}
