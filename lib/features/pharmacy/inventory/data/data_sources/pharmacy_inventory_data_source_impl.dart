import 'package:chefaa/core/services/network_service.dart';
import 'package:chefaa/features/pharmacy/inventory/data/data_sources/pharmacy_inventory_data_source.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: PharmacyInventoryDataSource)
class PharmacyInventoryDataSourceImpl implements PharmacyInventoryDataSource {
  final NetworkService _networkService;

  PharmacyInventoryDataSourceImpl(this._networkService);

  @override
  Future<Response> addMedicine(Map<String, dynamic> body) {
    return _networkService.dio.post("/pharmacy/inventory/add", data: body);
  }

  @override
  Future<Response> getMedicines({String? search, String? filter}) {
    return _networkService.dio.get(
      "/pharmacy/inventory",
      queryParameters: {
        if (search != null && search.isNotEmpty) "search": search,
        if (filter != null && filter.isNotEmpty) "filter": filter,
      },
    );
  }

  @override
  Future<Response> getLowStock({String? search}) {
    return _networkService.dio.get(
      "/pharmacy/inventory/low-stock",
      queryParameters: {
        if (search != null && search.isNotEmpty) "search": search,
      },
    );
  }

  @override
  Future<Response> searchMedicines(String query) {
    return _networkService.dio.get(
      "/pharmacy/inventory/search",
      queryParameters: {
        "q": query,
      },
    );
  }
}
