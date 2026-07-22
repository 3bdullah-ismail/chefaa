class OrdersListResponse {
  final bool success;
  final List<OrderSummaryItem> data;

  OrdersListResponse({
    required this.success,
    required this.data,
  });

  factory OrdersListResponse.fromJson(Map<String, dynamic> json) {
    return OrdersListResponse(
      success: json['success'] ?? false,
      data: json['data'] != null
          ? (json['data'] as List)
              .map((e) => OrderSummaryItem.fromJson(e))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}

class OrderSummaryItem {
  final String id;
  final String orderNumber;
  final String status;
  final num totalPrice;
  final String paymentMethod;
  final String createdAt;
  final int itemsCount;
  final String pharmacyName;

  OrderSummaryItem({
    required this.id,
    required this.orderNumber,
    required this.status,
    required this.totalPrice,
    required this.paymentMethod,
    required this.createdAt,
    required this.itemsCount,
    required this.pharmacyName,
  });

  factory OrderSummaryItem.fromJson(Map<String, dynamic> json) {
    final items = json['items'] as List? ?? json['orderItems'] as List? ?? [];
    return OrderSummaryItem(
      id: json['_id'] ?? json['id'] ?? '',
      orderNumber: json['orderNumber'] ?? '',
      status: json['status'] ?? json['orderStatus'] ?? '',
      totalPrice: json['totalPrice'] ?? json['total'] ?? 0,
      paymentMethod: json['paymentMethod'] ?? 'Cash',
      createdAt: json['createdAt'] ?? '',
      itemsCount: json['itemsCount'] ?? items.length,
      pharmacyName: json['pharmacyName'] ??
          (json['pharmacy'] is Map ? json['pharmacy']['name'] ?? '' : ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderNumber': orderNumber,
      'status': status,
      'totalPrice': totalPrice,
      'paymentMethod': paymentMethod,
      'createdAt': createdAt,
      'itemsCount': itemsCount,
      'pharmacyName': pharmacyName,
    };
  }
}
