import 'working_hours.dart';
import 'location.dart';

class Data {
  Data({
      this.id, 
      this.pharmacyName, 
      this.openNow, 
      this.alwaysOpen, 
      this.rating, 
      this.totalReviews, 
      this.deliveryTime, 
      this.deliveryFee, 
      this.minimumOrder, 
      this.phone, 
      this.about, 
      this.services, 
      this.workingHours, 
      this.addressText, 
      this.location, 
      this.availableMedicinesCount,});

  Data.fromJson(dynamic json) {
    id = json['_id'];
    pharmacyName = json['pharmacyName'];
    openNow = json['openNow'];
    alwaysOpen = json['alwaysOpen'];
    rating = json['rating'];
    totalReviews = json['totalReviews'];
    deliveryTime = json['deliveryTime'];
    deliveryFee = json['deliveryFee'];
    minimumOrder = json['minimumOrder'];
    phone = json['phone'];
    about = json['about'];
    if (json['services'] != null) {
      services = [];
      json['services'].forEach((v) {
        services?.add(v);
      });
    }
    if (json['workingHours'] != null) {
      workingHours = [];
      json['workingHours'].forEach((v) {
        workingHours?.add(WorkingHours.fromJson(v));
      });
    }
    addressText = json['addressText'];
    location = json['location'] != null ? Location.fromJson(json['location']) : null;
    availableMedicinesCount = json['availableMedicinesCount'];
  }
  String? id;
  String? pharmacyName;
  bool? openNow;
  bool? alwaysOpen;
  num? rating;
  num? totalReviews;
  String? deliveryTime;
  num? deliveryFee;
  num? minimumOrder;
  String? phone;
  String? about;
  List<dynamic>? services;
  List<WorkingHours>? workingHours;
  String? addressText;
  Location? location;
  num? availableMedicinesCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['pharmacyName'] = pharmacyName;
    map['openNow'] = openNow;
    map['alwaysOpen'] = alwaysOpen;
    map['rating'] = rating;
    map['totalReviews'] = totalReviews;
    map['deliveryTime'] = deliveryTime;
    map['deliveryFee'] = deliveryFee;
    map['minimumOrder'] = minimumOrder;
    map['phone'] = phone;
    map['about'] = about;
    if (services != null) {
      map['services'] = services?.map((v) => v.toJson()).toList();
    }
    if (workingHours != null) {
      map['workingHours'] = workingHours?.map((v) => v.toJson()).toList();
    }
    map['addressText'] = addressText;
    if (location != null) {
      map['location'] = location?.toJson();
    }
    map['availableMedicinesCount'] = availableMedicinesCount;
    return map;
  }

}
