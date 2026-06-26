import 'package:chefaa/presentation/patient/search/domain/entities/clinic_model.dart';

class SearchResponse extends ClinicModel {
  final String? id;
  final String? specialization;
  final num? age;
  final num? yearsOfExperience;
  final String? image;
  final String? about;
  final List<String>? degrees;
  final String? gender;
  final num? ratingValue;
  final List<String>? prePaymentNumbers;
  final num? clinicConsultationPrice;
  final List<dynamic>? reviews;
  final List<Clinics>? clinics;

  SearchResponse({
    this.id,
    this.specialization,
    this.age,
    this.yearsOfExperience,
    this.image,
    this.about,
    this.degrees,
    this.gender,
    this.ratingValue,
    this.prePaymentNumbers,
    this.clinicConsultationPrice,
    this.reviews,
    this.clinics,
    String? name,
    Clinics? specificClinic,
    List<DateTime>? availableDaysOverride,
  }) : super(
         doctorName: name ?? 'Unknown',
         doctorSpecialty: specialization ?? 'General',
         doctorRating: (ratingValue ?? 0).toString(),
         doctorRatingCount: '0',
         clinicPrice: (specificClinic?.price ?? clinicConsultationPrice ?? 0)
             .toString(),
         doctorImageUrl: image,
         doctorGender: gender,
         clinicLocation:
             specificClinic?.address ??
             (clinics != null && clinics.isNotEmpty
                 ? clinics.first.address
                 : null),
         availableDays:
             availableDaysOverride ??
             _parseDaysStatic(
               specificClinic != null ? [specificClinic] : clinics,
             ),
         clinicId: specificClinic?.id ?? id ?? '',
         clinicName:
             specificClinic?.name ??
             (clinics != null && clinics.isNotEmpty
                 ? clinics.first.name ?? ''
                 : ''),
       );

  factory SearchResponse.fromJson(dynamic json) {
    final clinicsList = json['clinics'] != null
        ? (json['clinics'] as List).map((v) => Clinics.fromJson(v)).toList()
        : <Clinics>[];

    return SearchResponse(
      id: json['_id'],
      name: json['name'],
      specialization: json['specialization'],
      age: json['age'],
      yearsOfExperience: json['yearsOfExperience'],
      image: json['image'],
      about: json['about'],
      degrees: json['degrees'] != null
          ? List<String>.from(json['degrees'])
          : [],
      gender: json['gender'],
      ratingValue: json['rating'],
      prePaymentNumbers: json['prePaymentNumbers'] != null
          ? List<String>.from(json['prePaymentNumbers'])
          : [],
      clinicConsultationPrice: json['clinicConsultationPrice'],
      reviews: json['reviews'] != null
          ? List<dynamic>.from(json['reviews'])
          : [],
      clinics: clinicsList,
    );
  }

  static List<SearchResponse> fromJsonList(List<dynamic> jsonList) {
    List<SearchResponse> allClinicResults = [];

    for (var doctorJson in jsonList) {
      final clinics = doctorJson['clinics'] != null
          ? (doctorJson['clinics'] as List)
                .map((v) => Clinics.fromJson(v))
                .toList()
          : <Clinics>[];

      if (clinics.isEmpty) {
        allClinicResults.add(SearchResponse.fromJson(doctorJson));
      } else {
        for (var clinic in clinics) {
          final clinicDays = _parseDaysStatic([clinic]);
          allClinicResults.add(
            SearchResponse(
              id: doctorJson['_id'],
              name: doctorJson['name'],
              specialization: doctorJson['specialization'],
              age: doctorJson['age'],
              yearsOfExperience: doctorJson['yearsOfExperience'],
              image: doctorJson['image'],
              about: doctorJson['about'],
              degrees: doctorJson['degrees'] != null
                  ? List<String>.from(doctorJson['degrees'])
                  : [],
              gender: doctorJson['gender'],
              ratingValue: doctorJson['rating'],
              prePaymentNumbers: doctorJson['prePaymentNumbers'] != null
                  ? List<String>.from(doctorJson['prePaymentNumbers'])
                  : [],
              clinicConsultationPrice: doctorJson['clinicConsultationPrice'],
              reviews: doctorJson['reviews'] != null
                  ? List<dynamic>.from(doctorJson['reviews'])
                  : [],
              clinics: [clinic],
              specificClinic: clinic,
              availableDaysOverride: clinicDays,
            ),
          );
        }
      }
    }
    return allClinicResults;
  }


  static List<DateTime> _parseDaysStatic(List<Clinics>? clinics) {
    if (clinics == null || clinics.isEmpty) {
      return const [];
    }

    final weekDays = <int>{};

    for (final clinic in clinics) {
      final days = clinic.defaultSchedule?.days;

      if (days == null || days.isEmpty) continue;

      for (final day in days) {
        if (!_isActiveDay(day.isActive)) continue;

        final weekday = _weekdayFromString(day.day);

        if (weekday == null) continue;

        weekDays.add(weekday);
      }
    }

    if (weekDays.isEmpty) {
      return const [];
    }

    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day);

    final dates = List.generate(
      7,
          (i) => start.add(Duration(days: i)),
    ).where(
          (date) => weekDays.contains(date.weekday),
    ).toList(growable: false);


    return dates;
  }  static bool _isActiveDay(bool? isActive) {
    return isActive == true;
  }

  static int? _weekdayFromString(String? rawDay) {
    final normalized = _normalizeDayName(rawDay);
    if (normalized == null) return null;

    const map = {
      'monday': DateTime.monday,
      'mon': DateTime.monday,
      'tuesday': DateTime.tuesday,
      'tue': DateTime.tuesday,
      'tues': DateTime.tuesday,
      'wednesday': DateTime.wednesday,
      'wed': DateTime.wednesday,
      'thursday': DateTime.thursday,
      'thu': DateTime.thursday,
      'thur': DateTime.thursday,
      'thurs': DateTime.thursday,
      'friday': DateTime.friday,
      'fri': DateTime.friday,
      'saturday': DateTime.saturday,
      'sat': DateTime.saturday,
      'sunday': DateTime.sunday,
      'sun': DateTime.sunday,
    };
    return map[normalized];
  }

  static String? _normalizeDayName(String? rawDay) {
    if (rawDay == null) return null;
    final normalized = rawDay.trim().toLowerCase();
    if (normalized.isEmpty) return null;
    return normalized.replaceAll(RegExp(r'[\s._-]'), '');
  }
}

class Clinics {
  String? id;
  String? doctorId;
  String? name;
  String? city;
  String? address;
  Location? location;
  String? color;
  DefaultSchedule? defaultSchedule;
  num? price;
  String? operatingLicense;
  String? status;
  dynamic activatedAt;
  dynamic activatedBy;
  String? rejectionReason;
  String? createdAt;
  String? updatedAt;
  num? v;

  Clinics({
    this.id,
    this.doctorId,
    this.name,
    this.city,
    this.address,
    this.location,
    this.color,
    this.defaultSchedule,
    this.price,
    this.operatingLicense,
    this.status,
    this.activatedAt,
    this.activatedBy,
    this.rejectionReason,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  Clinics.fromJson(dynamic json) {
    id = json['_id'];
    doctorId = json['doctorId'];
    name = json['name'];
    city = json['city'];
    address = json['address'];
    location = json['location'] != null
        ? Location.fromJson(json['location'])
        : null;
    color = json['color'];
    defaultSchedule = json['defaultSchedule'] != null
        ? DefaultSchedule.fromJson(json['defaultSchedule'])
        : null;
    price = json['price'];
    operatingLicense = json['operatingLicense'];
    status = json['status'];
    activatedAt = json['activatedAt'];
    activatedBy = json['activatedBy'];
    rejectionReason = json['rejectionReason'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['doctorId'] = doctorId;
    map['name'] = name;
    map['city'] = city;
    map['address'] = address;
    if (location != null) map['location'] = location?.toJson();
    map['color'] = color;
    if (defaultSchedule != null) {
      map['defaultSchedule'] = defaultSchedule?.toJson();
    }
    map['price'] = price;
    map['operatingLicense'] = operatingLicense;
    map['status'] = status;
    map['activatedAt'] = activatedAt;
    map['activatedBy'] = activatedBy;
    map['rejectionReason'] = rejectionReason;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }
}

class DefaultSchedule {
  List<Days>? days;
  num? slotDuration;
  num? dailyCapacity;
  num? patientsPerSlot;

  DefaultSchedule({
    this.days,
    this.slotDuration,
    this.dailyCapacity,
    this.patientsPerSlot,
  });

  DefaultSchedule.fromJson(dynamic json) {
    if (json['days'] != null) {
      days = (json['days'] as List).map((v) => Days.fromJson(v)).toList();
    }
    slotDuration = json['slotDuration'];
    dailyCapacity = json['dailyCapacity'];
    patientsPerSlot = json['patientsPerSlot'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (days != null) {
      map['days'] = days?.map((v) => v.toJson()).toList();
    }
    map['slotDuration'] = slotDuration;
    map['dailyCapacity'] = dailyCapacity;
    map['patientsPerSlot'] = patientsPerSlot;
    return map;
  }
}

class Days {
  String? day;
  bool? isActive;
  num? open;
  num? close;
  List<Breaks>? breaks;
  dynamic slotDuration;
  dynamic dailyCapacity;
  dynamic patientsPerSlot;
  bool? isDayLocked;
  bool? isBookingLocked;

  Days({
    this.day,
    this.isActive,
    this.open,
    this.close,
    this.breaks,
    this.slotDuration,
    this.dailyCapacity,
    this.patientsPerSlot,
    this.isDayLocked,
    this.isBookingLocked,
  });

  Days.fromJson(dynamic json) {
    day = json['day'];
    isActive = json['isActive'] == true || json['isActive'] == 1;
    open = json['open'];
    close = json['close'];
    if (json['breaks'] != null) {
      breaks = (json['breaks'] as List).map((v) => Breaks.fromJson(v)).toList();
    }
    slotDuration = json['slotDuration'];
    dailyCapacity = json['dailyCapacity'];
    patientsPerSlot = json['patientsPerSlot'];
    isDayLocked = json['isDayLocked'];
    isBookingLocked = json['isBookingLocked'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['day'] = day;
    map['isActive'] = isActive;
    map['open'] = open;
    map['close'] = close;
    if (breaks != null) {
      map['breaks'] = breaks?.map((v) => v.toJson()).toList();
    }
    map['slotDuration'] = slotDuration;
    map['dailyCapacity'] = dailyCapacity;
    map['patientsPerSlot'] = patientsPerSlot;
    map['isDayLocked'] = isDayLocked;
    map['isBookingLocked'] = isBookingLocked;
    return map;
  }
}

class Breaks {
  num? start;
  num? end;
  String? label;

  Breaks({this.start, this.end, this.label});

  Breaks.fromJson(dynamic json) {
    start = json['start'];
    end = json['end'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['start'] = start;
    map['end'] = end;
    map['label'] = label;
    return map;
  }
}

class Location {
  String? type;
  List<num>? coordinates;

  Location({this.type, this.coordinates});

  Location.fromJson(dynamic json) {
    type = json['type'];
    coordinates = json['coordinates'] != null
        ? json['coordinates'].cast<num>()
        : [];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['coordinates'] = coordinates;
    return map;
  }
}
