import 'package:chefaa/core/imports/imports.dart';
import 'package:chefaa/core/services/network_service.dart';
import 'lab_results_remote_data_source.dart';

@Injectable(as: LabResultsRemoteDataSource)
class LabResultsRemoteDataSourceImpl implements LabResultsRemoteDataSource {
  final NetworkService _networkService;

  LabResultsRemoteDataSourceImpl(this._networkService);

  @override
  Future<Response> getLabResults() async {
    return _networkService.dio.get('/patient/my-lab-results');
  }
}
