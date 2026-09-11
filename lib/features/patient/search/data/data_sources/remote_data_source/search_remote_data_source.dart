
import 'package:chefaa/core/imports/imports.dart';
abstract class SearchRemoteDataSource {
  Future<Response> filterSearch({
    String? searchText,
    String? specialization,
    String? gender,
    String? location,
  });
}
