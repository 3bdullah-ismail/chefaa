import 'Location.dart';
import 'DaysOfWeek.dart';

class Clinics {
  Clinics({
    this.location,
    this.id,
    this.doctorId,
    this.name,
    this.city,
    this.address,
    this.availableDays,
    this.daysOfWeek,
    this.dailyCapacity,
    this.slotDuration,
    this.price,
    this.capacityPerSlot,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  Clinics.fromJson(dynamic json) {
    location = json['location'] != null
        ? Location.fromJson(json['location'])
        : null;
    id = json['_id'];
    doctorId = json['doctorId'];
    name = json['name'];
    city = json['city'];
    address = json['address'];
    if (json['availableDays'] != null) {
      availableDays = [];
      json['availableDays'].forEach((v) {
        availableDays?.add(Dynamic.fromJson(v));
      });
    }
    if (json['daysOfWeek'] != null) {
      daysOfWeek = [];
      json['daysOfWeek'].forEach((v) {
        daysOfWeek?.add(DaysOfWeek.fromJson(v));
      });
    }
    dailyCapacity = json['dailyCapacity'];
    slotDuration = json['slotDuration'];
    price = json['price'];
    capacityPerSlot = json['capacityPerSlot'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  Location? location;
  String? id;
  String? doctorId;
  String? name;
  String? city;
  String? address;
  List<dynamic>? availableDays;
  List<DaysOfWeek>? daysOfWeek;
  num? dailyCapacity;
  num? slotDuration;
  num? price;
  num? capacityPerSlot;
  String? createdAt;
  String? updatedAt;
  num? v;

  get Dynamic => null;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (location != null) {
      map['location'] = location?.toJson();
    }
    map['_id'] = id;
    map['doctorId'] = doctorId;
    map['name'] = name;
    map['city'] = city;
    map['address'] = address;
    if (availableDays != null) {
      map['availableDays'] = availableDays?.map((v) => v.toJson()).toList();
    }
    if (daysOfWeek != null) {
      map['daysOfWeek'] = daysOfWeek?.map((v) => v.toJson()).toList();
    }
    map['dailyCapacity'] = dailyCapacity;
    map['slotDuration'] = slotDuration;
    map['price'] = price;
    map['capacityPerSlot'] = capacityPerSlot;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }
}
