class PharmacyStatusResponse {
  final bool? success;
  final String? message;
  final PharmacyStatusData? data;

  PharmacyStatusResponse({this.success, this.message, this.data});

  factory PharmacyStatusResponse.fromJson(Map<String, dynamic> json) {
    return PharmacyStatusResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? PharmacyStatusData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (success != null) 'success': success,
      if (message != null) 'message': message,
      if (data != null) 'data': data!.toJson(),
    };
  }
}

class PharmacyStatusData {
  final bool? openNow;
  final bool? deliveryAvailable;

  PharmacyStatusData({this.openNow, this.deliveryAvailable});

  factory PharmacyStatusData.fromJson(Map<String, dynamic> json) {
    return PharmacyStatusData(
      openNow: json['openNow'] as bool?,
      deliveryAvailable: json['deliveryAvailable'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (openNow != null) 'openNow': openNow,
      if (deliveryAvailable != null) 'deliveryAvailable': deliveryAvailable,
    };
  }
}
