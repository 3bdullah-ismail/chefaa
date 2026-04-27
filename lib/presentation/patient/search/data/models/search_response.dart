import '../../domain/entities/doctor_model.dart';

class SearchResponse extends DoctorModel {
  final String? id;
  final UserId? userId;
  final String? specialization;
  final String? image;
  final String? about;
  final String? membershipPdf;
  final List<dynamic>? degrees;
  final bool? preOnlineConsultation;
  final List<Clinics>? clinics;
  final String? paymentOption;
  final List<dynamic>? prePaymentNumbers;
  final num? ratingValue;
  final num? videoConsultationPrice;
  final num? clinicConsultationPrice;
  final List<dynamic>? reviews;
  final String? createdAt;
  final String? updatedAt;
  final num? v;

  SearchResponse({
    this.id,
    this.userId,
    this.specialization,
    this.image,
    this.about,
    this.membershipPdf,
    this.degrees,
    this.preOnlineConsultation,
    this.clinics,
    this.paymentOption,
    this.prePaymentNumbers,
    this.ratingValue,
    this.videoConsultationPrice,
    this.clinicConsultationPrice,
    this.reviews,
    this.createdAt,
    this.updatedAt,
    this.v,
    String? gender,
  }) : super(
         name: userId?.name ?? 'Unknown',
         specialty: specialization ?? 'General',
         rating: (ratingValue ?? 0.0).toString(),
         ratingCount: (reviews?.length ?? 0).toString(),
         price: (clinics != null && clinics.isNotEmpty)
             ? clinics.first.price.toString()
             : (videoConsultationPrice ?? 0).toString(),
         imageUrl: image,
         gender: gender,
         location: (clinics != null && clinics.isNotEmpty)
             ? clinics.first.address
             : '',
         clinkId: (clinics != null && clinics.isNotEmpty)
             ? clinics.first.id ?? ''
             : '',
         availableDays: _parseDays(clinics),
       );

  static List<DateTime> _parseDays(List<Clinics>? clinics) {
    if (clinics == null || clinics.isEmpty) {
      return const <DateTime>[];
    }

    final explicitDays = clinics
        .expand((clinic) => clinic.availableDays ?? const <dynamic>[])
        .map(_parseDateValue)
        .whereType<DateTime>()
        .toSet()
        .toList();

    if (explicitDays.isNotEmpty) {
      explicitDays.sort((a, b) => a.compareTo(b));
      return explicitDays;
    }

    final weekDays = clinics
        .expand((clinic) => clinic.daysOfWeek ?? const <DaysOfWeek>[])
        .map((day) => _weekdayFromString(day.day))
        .whereType<int>()
        .toSet();

    if (weekDays.isEmpty) {
      return const <DateTime>[];
    }

    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day);
    final generatedDays = <DateTime>[];

    for (var i = 0; i < 14; i++) {
      final date = start.add(Duration(days: i));
      if (weekDays.contains(date.weekday)) {
        generatedDays.add(date);
      }
    }

    return generatedDays;
  }

  static DateTime? _parseDateValue(dynamic value) {
    if (value is DateTime) return value.toLocal();

    if (value is String) {
      return DateTime.tryParse(value)?.toLocal();
    }

    if (value is int) {
      final millis = value > 9999999999 ? value : value * 1000;
      return DateTime.fromMillisecondsSinceEpoch(millis).toLocal();
    }

    if (value is Map<String, dynamic>) {
      final nested = value[r'$date'] ?? value['date'] ?? value['value'];
      return _parseDateValue(nested);
    }

    return null;
  }

  static int? _weekdayFromString(String? rawDay) {
    if (rawDay == null || rawDay.trim().isEmpty) return null;

    final normalized = rawDay.trim().toLowerCase();
    const map = {
      'mon': DateTime.monday,
      'monday': DateTime.monday,
      'tue': DateTime.tuesday,
      'tues': DateTime.tuesday,
      'tuesday': DateTime.tuesday,
      'wed': DateTime.wednesday,
      'wednesday': DateTime.wednesday,
      'thu': DateTime.thursday,
      'thur': DateTime.thursday,
      'thurs': DateTime.thursday,
      'thursday': DateTime.thursday,
      'fri': DateTime.friday,
      'friday': DateTime.friday,
      'sat': DateTime.saturday,
      'saturday': DateTime.saturday,
      'sun': DateTime.sunday,
      'sunday': DateTime.sunday,
    };

    return map[normalized];
  }

  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    final List<Clinics>? clinics = json['clinics'] != null
        ? List<dynamic>.from(
            json['clinics'],
          ).map((v) => Clinics.fromJson(v)).toList()
        : null;

    final List<dynamic>? degrees = json['degrees'] != null
        ? List<dynamic>.from(json['degrees'])
        : null;

    final List<dynamic>? prePaymentNumbers = json['prePaymentNumbers'] != null
        ? List<dynamic>.from(json['prePaymentNumbers'])
        : null;

    final List<dynamic>? reviews = json['reviews'] != null
        ? List<dynamic>.from(json['reviews'])
        : null;

    return SearchResponse(
      id: json['_id'],
      userId: json['userId'] != null ? UserId.fromJson(json['userId']) : null,
      specialization: json['specialization'],
      image: json['image'],
      about: json['about'],
      membershipPdf: json['membershipPdf'],
      degrees: degrees,
      preOnlineConsultation: json['preOnlineConsultation'],
      clinics: clinics,
      paymentOption: json['paymentOption'],
      prePaymentNumbers: prePaymentNumbers,
      ratingValue: json['rating'],
      videoConsultationPrice: json['videoConsultationPrice'],
      clinicConsultationPrice: json['clinicConsultationPrice'],
      reviews: reviews,
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
      gender: json['gender'],
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    if (userId != null) map['userId'] = userId?.toJson();
    map['specialization'] = specialization;
    map['image'] = image;
    map['about'] = about;
    map['membershipPdf'] = membershipPdf;
    map['degrees'] = degrees;
    map['preOnlineConsultation'] = preOnlineConsultation;
    if (clinics != null)
      map['clinics'] = clinics?.map((v) => v.toJson()).toList();
    map['paymentOption'] = paymentOption;
    map['prePaymentNumbers'] = prePaymentNumbers;
    map['rating'] = ratingValue;
    map['videoConsultationPrice'] = videoConsultationPrice;
    map['clinicConsultationPrice'] = clinicConsultationPrice;
    map['reviews'] = reviews;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    map['gender'] = gender;
    return map;
  }
}

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
    availableDays = json['availableDays'] != null
        ? List<dynamic>.from(json['availableDays'])
        : null;
    if (json['daysOfWeek'] != null) {
      daysOfWeek = List<dynamic>.from(
        json['daysOfWeek'],
      ).map((v) => DaysOfWeek.fromJson(v)).toList();
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

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (location != null) map['location'] = location?.toJson();
    map['_id'] = id;
    map['doctorId'] = doctorId;
    map['name'] = name;
    map['city'] = city;
    map['address'] = address;
    map['availableDays'] = availableDays;
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

class DaysOfWeek {
  DaysOfWeek({this.day, this.open, this.close, this.id, this.breaks});

  DaysOfWeek.fromJson(dynamic json) {
    day = json['day'];
    open = json['open'];
    close = json['close'];
    id = json['_id'];
    breaks = json['breaks'] != null ? List<dynamic>.from(json['breaks']) : null;
  }

  String? day;
  String? open;
  String? close;
  String? id;
  List<dynamic>? breaks;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['day'] = day;
    map['open'] = open;
    map['close'] = close;
    map['_id'] = id;
    map['breaks'] = breaks;
    return map;
  }
}

class Location {
  Location({this.coordinates, this.type});

  Location.fromJson(dynamic json) {
    coordinates = json['coordinates'] != null
        ? List<num>.from(json['coordinates'])
        : [];
    type = json['type'];
  }

  List<num>? coordinates;
  String? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['coordinates'] = coordinates;
    map['type'] = type;
    return map;
  }
}

class UserId {
  UserId({this.id, this.name, this.email, this.phoneNumber});

  UserId.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
  }

  String? id;
  String? name;
  String? email;
  String? phoneNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['phoneNumber'] = phoneNumber;
    return map;
  }
}
