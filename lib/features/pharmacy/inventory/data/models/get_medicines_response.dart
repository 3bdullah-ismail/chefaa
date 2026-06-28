import 'add_medicine_response.dart';

class GetMedicinesResponse {
  final bool? success;
  final GetMedicinesData? data;

  GetMedicinesResponse({this.success, this.data});

  factory GetMedicinesResponse.fromJson(Map<String, dynamic> json) {
    return GetMedicinesResponse(
      success: json['success'] as bool?,
      data: json['data'] != null
          ? GetMedicinesData.fromJson(json['data'] as Map<String, dynamic>)
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

class GetMedicinesData {
  final List<MedicineData>? medicines;
  final List<MedicineData>? lowStockItems;
  final SummaryData? summary;
  final PaginationData? pagination;

  GetMedicinesData({
    this.medicines,
    this.lowStockItems,
    this.summary,
    this.pagination,
  });

  factory GetMedicinesData.fromJson(Map<String, dynamic> json) {
    return GetMedicinesData(
      medicines: json['medicines'] != null
          ? (json['medicines'] as List)
              .map((item) => MedicineData.fromJson(item as Map<String, dynamic>))
              .toList()
          : null,
      lowStockItems: json['lowStockItems'] != null
          ? (json['lowStockItems'] as List)
              .map((item) => MedicineData.fromJson(item as Map<String, dynamic>))
              .toList()
          : null,
      summary: json['summary'] != null
          ? SummaryData.fromJson(json['summary'] as Map<String, dynamic>)
          : null,
      pagination: json['pagination'] != null
          ? PaginationData.fromJson(json['pagination'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (medicines != null)
        'medicines': medicines!.map((item) => item.toJson()).toList(),
      if (lowStockItems != null)
        'lowStockItems': lowStockItems!.map((item) => item.toJson()).toList(),
      if (summary != null) 'summary': summary!.toJson(),
      if (pagination != null) 'pagination': pagination!.toJson(),
    };
  }
}

class SummaryData {
  final num? total;
  final num? lowStockCount;
  final num? outOfStockCount;

  SummaryData({this.total, this.lowStockCount, this.outOfStockCount});

  factory SummaryData.fromJson(Map<String, dynamic> json) {
    return SummaryData(
      total: json['total'] as num?,
      lowStockCount: json['lowStockCount'] as num?,
      outOfStockCount: json['outOfStockCount'] as num?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (total != null) 'total': total,
      if (lowStockCount != null) 'lowStockCount': lowStockCount,
      if (outOfStockCount != null) 'outOfStockCount': outOfStockCount,
    };
  }
}

class PaginationData {
  final num? total;
  final num? page;
  final num? totalPages;

  PaginationData({this.total, this.page, this.totalPages});

  factory PaginationData.fromJson(Map<String, dynamic> json) {
    return PaginationData(
      total: json['total'] as num?,
      page: json['page'] as num?,
      totalPages: json['totalPages'] as num?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (total != null) 'total': total,
      if (page != null) 'page': page,
      if (totalPages != null) 'totalPages': totalPages,
    };
  }
}
