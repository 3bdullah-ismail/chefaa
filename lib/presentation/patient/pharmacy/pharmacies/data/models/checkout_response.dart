class CheckoutResponse {
  final bool success;
  final String message;
  final CheckoutResponseData? data;

  CheckoutResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory CheckoutResponse.fromJson(Map<String, dynamic> json) {
    return CheckoutResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? CheckoutResponseData.fromJson(json['data'])
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

class CheckoutResponseData {
  final String orderId;
  final String orderNumber;
  final String orderType;
  final String pharmacyName;
  final String deliveryTime;
  final int itemsCount;
  final num subtotal;
  final num deliveryFee;
  final num totalPrice;
  final String paymentMethod;

  CheckoutResponseData({
    required this.orderId,
    required this.orderNumber,
    required this.orderType,
    required this.pharmacyName,
    required this.deliveryTime,
    required this.itemsCount,
    required this.subtotal,
    required this.deliveryFee,
    required this.totalPrice,
    required this.paymentMethod,
  });

  factory CheckoutResponseData.fromJson(Map<String, dynamic> json) {
    return CheckoutResponseData(
      orderId: json['orderId'] ?? '',
      orderNumber: json['orderNumber'] ?? '',
      orderType: json['orderType'] ?? '',
      pharmacyName: json['pharmacyName'] ?? '',
      deliveryTime: json['deliveryTime'] ?? '',
      itemsCount: json['itemsCount'] ?? 0,
      subtotal: json['subtotal'] ?? 0,
      deliveryFee: json['deliveryFee'] ?? 0,
      totalPrice: json['totalPrice'] ?? 0,
      paymentMethod: json['paymentMethod'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'orderNumber': orderNumber,
      'orderType': orderType,
      'pharmacyName': pharmacyName,
      'deliveryTime': deliveryTime,
      'itemsCount': itemsCount,
      'subtotal': subtotal,
      'deliveryFee': deliveryFee,
      'totalPrice': totalPrice,
      'paymentMethod': paymentMethod,
    };
  }
}
