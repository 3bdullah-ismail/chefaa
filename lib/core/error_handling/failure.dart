import 'package:dio/dio.dart';

import 'api_error_model.dart';

abstract class Failure {
  final String message;

  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure(super.message);
  static const String unexpectedError =
      'An unexpected error occurred. Please try again later.';
  factory ServerFailure.fromDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(
          'Connection timeout with the server. Please try again.',
        );

      case DioExceptionType.sendTimeout:
        return ServerFailure(
          'Send timeout. Please check your internet connection.',
        );

      case DioExceptionType.receiveTimeout:
        return ServerFailure(
          'Receive timeout. The server is taking too long to respond.',
        );

      case DioExceptionType.badCertificate:
        return ServerFailure(
          'SSL certificate error. Connection is not secure.',
        );

      case DioExceptionType.cancel:
        return ServerFailure('Request to the server was cancelled.');

      case DioExceptionType.connectionError:
        return ServerFailure(
          'No internet connection. Please check your network.',
        );

      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          e.response?.statusCode,
          e.response?.data,
        );

      case DioExceptionType.unknown:
        if (e.message != null && e.message!.contains('SocketException')) {
          return ServerFailure('No internet connection.');
        }
        return ServerFailure(
          'An unexpected error occurred, please try again later.',
        );
    }
  }

  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      final errorModel = ApiErrorModel.fromJson(response);
      return ServerFailure(
        errorModel.message ?? 'Authentication or request error.',
      );
    } else if (statusCode == 404) {
      return ServerFailure(
        'Your request was not found. Please try again later.',
      );
    } else if (statusCode == 500) {
      return ServerFailure('Internal server error. Please try again later.');
    } else if (statusCode == 502 || statusCode == 503 || statusCode == 504) {
      return ServerFailure(
        'Server is currently unavailable. Please try again later.',
      );
    } else {
      return ServerFailure('Oops! Something went wrong, please try again.');
    }
  }
}
