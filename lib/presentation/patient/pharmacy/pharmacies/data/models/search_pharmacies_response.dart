class SearchPharmaciesResponse {
  final bool? success;
  final int? count;
  final List<SearchPharmacyData>? data;

  SearchPharmaciesResponse({this.success, this.count, this.data});

  factory SearchPharmaciesResponse.fromJson(Map<String, dynamic> json) {
    return SearchPharmaciesResponse(
      success: json['success'] as bool?,
      count: json['count'] as int?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => SearchPharmacyData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (success != null) 'success': success,
      if (count != null) 'count': count,
      if (data != null) 'data': data?.map((e) => e.toJson()).toList(),
    };
  }
}

class SearchPharmacyData {
  final String? id;
  final num? rating;
  final String? deliveryTime;
  final List<SearchPharmacyAddress>? addresses;
  final String? phone;
  final String? pharmacyName;
  final num? distanceKm;
  final int? availableMedicinesCount;

  SearchPharmacyData({
    this.id,
    this.rating,
    this.deliveryTime,
    this.addresses,
    this.phone,
    this.pharmacyName,
    this.distanceKm,
    this.availableMedicinesCount,
  });

  factory SearchPharmacyData.fromJson(Map<String, dynamic> json) {
    return SearchPharmacyData(
      id: json['_id'] as String?,
      rating: json['rating'] as num?,
      deliveryTime: json['deliveryTime'] as String?,
      addresses: (json['addresses'] as List<dynamic>?)
          ?.map((e) => SearchPharmacyAddress.fromJson(e as Map<String, dynamic>))
          .toList(),
      phone: json['phone'] as String?,
      pharmacyName: json['pharmacyName'] as String?,
      distanceKm: json['distanceKm'] as num?,
      availableMedicinesCount: json['availableMedicinesCount'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) '_id': id,
      if (rating != null) 'rating': rating,
      if (deliveryTime != null) 'deliveryTime': deliveryTime,
      if (addresses != null) 'addresses': addresses?.map((e) => e.toJson()).toList(),
      if (phone != null) 'phone': phone,
      if (pharmacyName != null) 'pharmacyName': pharmacyName,
      if (distanceKm != null) 'distanceKm': distanceKm,
      if (availableMedicinesCount != null) 'availableMedicinesCount': availableMedicinesCount,
    };
  }
}

class SearchPharmacyAddress {
  final String? addressText;
  final String? id;

  SearchPharmacyAddress({this.addressText, this.id});

  factory SearchPharmacyAddress.fromJson(Map<String, dynamic> json) {
    return SearchPharmacyAddress(
      addressText: json['addressText'] as String?,
      id: json['_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (addressText != null) 'addressText': addressText,
      if (id != null) '_id': id,
    };
  }
}

