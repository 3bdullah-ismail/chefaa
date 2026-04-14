import 'package:injectable/injectable.dart';

import '../data_sources/home_data_source.dart';
import 'home_repo.dart';

@Injectable(as: HomeRepo)
class HomeRepoImp implements HomeRepo {
  final HomeDataSource homeDataSource;

  HomeRepoImp(this.homeDataSource);
}
