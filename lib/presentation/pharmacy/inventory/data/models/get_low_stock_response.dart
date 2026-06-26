import 'add_medicine_response.dart';

class GetLowStockResponse {
  final bool? success;
  final GetLowStockData? data;

  GetLowStockResponse({this.success, this.data});

  factory GetLowStockResponse.fromJson(Map<String, dynamic> json) {
    return GetLowStockResponse(
      success: json['success'] as bool?,
      data: json['data'] != null
          ? GetLowStockData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (success != null) 'success': success,
      if (data != null) 'data': data!.toJson(),
    };
  }
}

class GetLowStockData {
  final List<MedicineData>? lowStockItems;
  final num? count;

  GetLowStockData({this.lowStockItems, this.count});

  factory GetLowStockData.fromJson(Map<String, dynamic> json) {
    return GetLowStockData(
      lowStockItems: json['lowStockItems'] != null
          ? (json['lowStockItems'] as List)
              .map((item) => MedicineData.fromJson(item as Map<String, dynamic>))
              .toList()
          : null,
      count: json['count'] as num?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (lowStockItems != null)
        'lowStockItems': lowStockItems!.map((item) => item.toJson()).toList(),
      if (count != null) 'count': count,
    };
  }
}
