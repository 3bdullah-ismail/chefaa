class OnlinePaymentResponse {
  final bool success;
  final String message;
  final OnlinePaymentData? data;

  OnlinePaymentResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory OnlinePaymentResponse.fromJson(Map<String, dynamic> json) {
    return OnlinePaymentResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? OnlinePaymentData.fromJson(json['data'])
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

class OnlinePaymentData {
  final String orderNumber;
  final String paymentStatus;
  final num totalPaid;

  OnlinePaymentData({
    required this.orderNumber,
    required this.paymentStatus,
    required this.totalPaid,
  });

  factory OnlinePaymentData.fromJson(Map<String, dynamic> json) {
    return OnlinePaymentData(
      orderNumber: json['orderNumber'] ?? '',
      paymentStatus: json['paymentStatus'] ?? '',
      totalPaid: json['totalPaid'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderNumber': orderNumber,
      'paymentStatus': paymentStatus,
      'totalPaid': totalPaid,
    };
  }
}
