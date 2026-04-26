import 'package:dio/dio.dart';

abstract class SearchDataSource {
  Future<Response> filterSearch({
    String? searchText,
    String? specialization,
    String? gender,
    String? location,
  });
}
