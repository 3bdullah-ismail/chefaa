class PharmacyProfileModel {
  final String id;
  final String pharmacyName;
  final bool openNow;
  final bool alwaysOpen;
  final double rating;
  final int totalReviews;
  final String deliveryTime;
  final num deliveryFee;
  final num minimumOrder;
  final String about;
  final List<String> services;
  final List<WorkingHourModel> workingHours;
  final String addressText;
  final LocationModel? location;
  final int availableMedicinesCount;

  PharmacyProfileModel({
    required this.id,
    required this.pharmacyName,
    required this.openNow,
    required this.alwaysOpen,
    required this.rating,
    required this.totalReviews,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.minimumOrder,
    required this.about,
    required this.services,
    required this.workingHours,
    required this.addressText,
    this.location,
    required this.availableMedicinesCount,
  });

  factory PharmacyProfileModel.fromJson(Map<String, dynamic> json) {
    return PharmacyProfileModel(
      id: json['_id'] ?? '',
      pharmacyName: json['pharmacyName'] ?? '',
      openNow: json['openNow'] ?? false,
      alwaysOpen: json['alwaysOpen'] ?? false,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      totalReviews: json['totalReviews'] ?? 0,
      deliveryTime: json['deliveryTime'] ?? '',
      deliveryFee: json['deliveryFee'] ?? 0,
      minimumOrder: json['minimumOrder'] ?? 0,
      about: json['about'] ?? '',
      services:
          (json['services'] as List?)?.map((e) => e.toString()).toList() ?? [],
      workingHours:
          (json['workingHours'] as List?)
              ?.map((e) => WorkingHourModel.fromJson(e))
              .toList() ??
          [],
      addressText: json['addressText'] ?? '',
      location: json['location'] != null
          ? LocationModel.fromJson(json['location'])
          : null,
      availableMedicinesCount: json['availableMedicinesCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'pharmacyName': pharmacyName,
      'openNow': openNow,
      'alwaysOpen': alwaysOpen,
      'rating': rating,
      'totalReviews': totalReviews,
      'deliveryTime': deliveryTime,
      'deliveryFee': deliveryFee,
      'minimumOrder': minimumOrder,
      'about': about,
      'services': services,
      'workingHours': workingHours.map((e) => e.toJson()).toList(),
      'addressText': addressText,
      'location': location?.toJson(),
      'availableMedicinesCount': availableMedicinesCount,
    };
  }
}

class WorkingHourModel {
  final String days;
  final String time;
  final String id;

  WorkingHourModel({required this.days, required this.time, required this.id});

  factory WorkingHourModel.fromJson(Map<String, dynamic> json) {
    return WorkingHourModel(
      days: json['days'] ?? '',
      time: json['time'] ?? '',
      id: json['_id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'days': days, 'time': time, '_id': id};
  }
}

class LocationModel {
  final String type;
  final List<double> coordinates;

  LocationModel({required this.type, required this.coordinates});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      type: json['type'] ?? '',
      coordinates:
          (json['coordinates'] as List?)
              ?.map((e) => (e as num).toDouble())
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {'type': type, 'coordinates': coordinates};
  }
}
