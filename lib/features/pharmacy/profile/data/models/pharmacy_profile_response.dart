class PharmacyProfileResponse {
  final bool? success;
  final PharmacyProfileData? data;

  PharmacyProfileResponse({this.success, this.data});

  factory PharmacyProfileResponse.fromJson(Map<String, dynamic> json) {
    return PharmacyProfileResponse(
      success: json['success'] as bool?,
      data: json['data'] != null
          ? PharmacyProfileData.fromJson(json['data'] as Map<String, dynamic>)
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

class PharmacyProfileData {
  final String? pharmacyName;
  final String? commercialRegisterNumber;
  final String? licenseExpiry;
  final num? rating;
  final bool? openNow;
  final bool? deliveryAvailable;
  final String? visibilityStatus;
  final PharmacyStats? stats;
  final List<dynamic>? workingHours;
  final List<dynamic>? addresses;
  final List<dynamic>? deliveryArea;
  final List<dynamic>? cityDeliveryPrices;
  final List<dynamic>? deliveryPricing;
  final List<dynamic>? paymentMethods;
  final String? deliveryTime;
  final PharmacySettings? settings;
  final String? about;

  PharmacyProfileData({
    this.pharmacyName,
    this.commercialRegisterNumber,
    this.licenseExpiry,
    this.rating,
    this.openNow,
    this.deliveryAvailable,
    this.visibilityStatus,
    this.stats,
    this.workingHours,
    this.addresses,
    this.deliveryArea,
    this.cityDeliveryPrices,
    this.deliveryPricing,
    this.paymentMethods,
    this.deliveryTime,
    this.settings,
    this.about,
  });

  factory PharmacyProfileData.fromJson(Map<String, dynamic> json) {
    return PharmacyProfileData(
      pharmacyName: json['pharmacyName'] as String?,
      commercialRegisterNumber: json['commercialRegisterNumber'] as String?,
      licenseExpiry: json['licenseExpiry'] as String?,
      rating: json['rating'] as num?,
      openNow: json['openNow'] as bool?,
      deliveryAvailable: json['deliveryAvailable'] as bool?,
      visibilityStatus: json['visibilityStatus'] as String?,
      stats: json['stats'] != null
          ? PharmacyStats.fromJson(json['stats'] as Map<String, dynamic>)
          : null,
      workingHours: json['workingHours'] as List<dynamic>?,
      addresses: json['addresses'] as List<dynamic>?,
      deliveryArea: json['deliveryArea'] as List<dynamic>?,
      cityDeliveryPrices: json['cityDeliveryPrices'] as List<dynamic>?,
      deliveryPricing: json['deliveryPricing'] as List<dynamic>?,
      paymentMethods: json['paymentMethods'] as List<dynamic>?,
      deliveryTime: json['deliveryTime'] as String?,
      settings: json['settings'] != null
          ? PharmacySettings.fromJson(json['settings'] as Map<String, dynamic>)
          : null,
      about: json['about'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (pharmacyName != null) 'pharmacyName': pharmacyName,
      if (commercialRegisterNumber != null)
        'commercialRegisterNumber': commercialRegisterNumber,
      if (licenseExpiry != null) 'licenseExpiry': licenseExpiry,
      if (rating != null) 'rating': rating,
      if (openNow != null) 'openNow': openNow,
      if (deliveryAvailable != null) 'deliveryAvailable': deliveryAvailable,
      if (visibilityStatus != null) 'visibilityStatus': visibilityStatus,
      if (stats != null) 'stats': stats!.toJson(),
      if (workingHours != null) 'workingHours': workingHours,
      if (addresses != null) 'addresses': addresses,
      if (deliveryArea != null) 'deliveryArea': deliveryArea,
      if (cityDeliveryPrices != null) 'cityDeliveryPrices': cityDeliveryPrices,
      if (deliveryPricing != null) 'deliveryPricing': deliveryPricing,
      if (paymentMethods != null) 'paymentMethods': paymentMethods,
      if (deliveryTime != null) 'deliveryTime': deliveryTime,
      if (settings != null) 'settings': settings!.toJson(),
      if (about != null) 'about': about,
    };
  }
}

class PharmacyStats {
  final num? rating;
  final num? totalMedicines;
  final num? totalOrders;

  PharmacyStats({this.rating, this.totalMedicines, this.totalOrders});

  factory PharmacyStats.fromJson(Map<String, dynamic> json) {
    return PharmacyStats(
      rating: json['rating'] as num?,
      totalMedicines: json['totalMedicines'] as num?,
      totalOrders: json['totalOrders'] as num?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (rating != null) 'rating': rating,
      if (totalMedicines != null) 'totalMedicines': totalMedicines,
      if (totalOrders != null) 'totalOrders': totalOrders,
    };
  }
}

class PharmacySettings {
  final bool? deliveryAvailable;
  final bool? openNow;
  final bool? prescriptionOnly;

  PharmacySettings({
    this.deliveryAvailable,
    this.openNow,
    this.prescriptionOnly,
  });

  factory PharmacySettings.fromJson(Map<String, dynamic> json) {
    return PharmacySettings(
      deliveryAvailable: json['deliveryAvailable'] as bool?,
      openNow: json['openNow'] as bool?,
      prescriptionOnly: json['prescriptionOnly'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (deliveryAvailable != null) 'deliveryAvailable': deliveryAvailable,
      if (openNow != null) 'openNow': openNow,
      if (prescriptionOnly != null) 'prescriptionOnly': prescriptionOnly,
    };
  }
}
