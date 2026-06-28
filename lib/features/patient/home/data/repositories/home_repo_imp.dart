import 'package:injectable/injectable.dart';

import 'package:chefaa/features/patient/home/data/data_sources/home_data_source.dart';
import 'package:chefaa/features/patient/home/domain/repositories/home_repo.dart';

@Injectable(as: HomeRepo)
class HomeRepoImp implements HomeRepo {
  final HomeDataSource homeDataSource;

  HomeRepoImp(this.homeDataSource);
}
