import 'data.dart';

class ReportAnalysis {
  String? message;
  String? error;
  bool? success;
  Data? data;

  ReportAnalysis({this.message, this.error, this.success, this.data});

  factory ReportAnalysis.fromJson(Map<String, dynamic> json) {
    return ReportAnalysis(
      message: json['message'] as String?,
      error: json['error'] as String?,
      success: json['success'] as bool?,
      data: json['data'] != null
          ? Data.fromJson(
              json['data'] is Map<String, dynamic>
                  ? json['data'] as Map<String, dynamic>
                  : Map<String, dynamic>.from(json['data'] as Map),
            )
          : null,
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

