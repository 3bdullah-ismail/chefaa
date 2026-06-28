import 'package:dio/dio.dart';

abstract class SearchRemoteDataSource {
  Future<Response> filterSearch({
    String? searchText,
    String? specialization,
    String? gender,
    String? location,
  });
}
