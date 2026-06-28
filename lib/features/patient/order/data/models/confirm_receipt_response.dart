class ConfirmReceiptResponse {
  final bool success;
  final String message;
  final ConfirmReceiptData? data;

  ConfirmReceiptResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory ConfirmReceiptResponse.fromJson(Map<String, dynamic> json) {
    return ConfirmReceiptResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? ConfirmReceiptData.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class ConfirmReceiptData {
  final String orderId;
  final String orderNumber;
  final String status;
  final String paymentStatus;
  final num totalPrice;
  final num commission;
  final num pharmacyEarns;
  final String transactionId;
  final List<VerifiedItem> verifiedItems;

  ConfirmReceiptData({
    required this.orderId,
    required this.orderNumber,
    required this.status,
    required this.paymentStatus,
    required this.totalPrice,
    required this.commission,
    required this.pharmacyEarns,
    required this.transactionId,
    required this.verifiedItems,
  });

  factory ConfirmReceiptData.fromJson(Map<String, dynamic> json) {
    return ConfirmReceiptData(
      orderId: json['orderId'] ?? '',
      orderNumber: json['orderNumber'] ?? '',
      status: json['status'] ?? '',
      paymentStatus: json['paymentStatus'] ?? '',
      totalPrice: json['totalPrice'] ?? 0,
      commission: json['commission'] ?? 0,
      pharmacyEarns: json['pharmacyEarns'] ?? 0,
      transactionId: json['transactionId'] ?? '',
      verifiedItems: json['verifiedItems'] != null
          ? (json['verifiedItems'] as List)
              .map((i) => VerifiedItem.fromJson(i))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'orderNumber': orderNumber,
      'status': status,
      'paymentStatus': paymentStatus,
      'totalPrice': totalPrice,
      'commission': commission,
      'pharmacyEarns': pharmacyEarns,
      'transactionId': transactionId,
      'verifiedItems': verifiedItems.map((i) => i.toJson()).toList(),
    };
  }
}

class VerifiedItem {
  final String medicineId;
  final int quantity;
  final num price;
  final String itemStatus;

  VerifiedItem({
    required this.medicineId,
    required this.quantity,
    required this.price,
    required this.itemStatus,
  });

  factory VerifiedItem.fromJson(Map<String, dynamic> json) {
    return VerifiedItem(
      medicineId: json['medicineId'] ?? '',
      quantity: json['quantity'] ?? 0,
      price: json['price'] ?? 0,
      itemStatus: json['itemStatus'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'medicineId': medicineId,
      'quantity': quantity,
      'price': price,
      'itemStatus': itemStatus,
    };
  }
}
