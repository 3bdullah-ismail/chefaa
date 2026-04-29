import 'package:chefaa/presentation/patient/search/domain/entities/doctor_model.dart';

class SearchResponse extends DoctorModel {
  final String? id;
  final List<Clinics>? clinics;

  SearchResponse({this.id, String? name, String? specialization, this.clinics})
    : super(
        name: name ?? 'Unknown',
        specialty: specialization ?? 'General',
        rating: '0.0',

        ratingCount: '0',
        price: (clinics != null && clinics.isNotEmpty)
            ? clinics.first.price.toString()
            : '0',
        imageUrl: '',

        location: (clinics != null && clinics.isNotEmpty)
            ? clinics.first.address ?? ''
            : '',
        clinkId: (clinics != null && clinics.isNotEmpty)
            ? clinics.first.id ?? ''
            : '',
        availableDays: _parseDays(clinics),
      );

  factory SearchResponse.fromJson(dynamic json) {
    return SearchResponse(
      id: json['_id'],
      name: json['name'],
      specialization: json['specialization'],
      clinics: json['clinics'] != null
          ? (json['clinics'] as List).map((v) => Clinics.fromJson(v)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['specialization'] = specialty;
    if (clinics != null) {
      map['clinics'] = clinics?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  static List<DateTime> _parseDays(List<Clinics>? clinics) {
    if (clinics == null || clinics.isEmpty) return const [];

    final weekDays = clinics
        .expand((clinic) => clinic.daysOfWeek ?? const <DaysOfWeek>[])
        .map((day) => _weekdayFromString(day.day))
        .whereType<int>()
        .toSet();

    if (weekDays.isEmpty) return const [];

    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day);

    return List.generate(
      14,
      (i) => start.add(Duration(days: i)),
    ).where((date) => weekDays.contains(date.weekday)).toList();
  }

  static int? _weekdayFromString(String? rawDay) {
    if (rawDay == null) return null;
    const map = {
      'monday': DateTime.monday,
      'tuesday': DateTime.tuesday,
      'wednesday': DateTime.wednesday,
      'thursday': DateTime.thursday,
      'friday': DateTime.friday,
      'saturday': DateTime.saturday,
      'sunday': DateTime.sunday,
    };
    return map[rawDay.trim().toLowerCase()];
  }
}

class Clinics {
  String? id;
  String? name;
  String? city;
  String? address;
  Location? location;
  num? price;
  List<DaysOfWeek>? daysOfWeek;

  Clinics({
    this.id,
    this.name,
    this.city,
    this.address,
    this.location,
    this.price,
    this.daysOfWeek,
  });

  Clinics.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    city = json['city'];
    address = json['address'];
    location = json['location'] != null
        ? Location.fromJson(json['location'])
        : null;
    price = json['price'];
    if (json['daysOfWeek'] != null) {
      daysOfWeek = (json['daysOfWeek'] as List)
          .map((v) => DaysOfWeek.fromJson(v))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'city': city,
      'address': address,
      'location': location?.toJson(),
      'price': price,
      'daysOfWeek': daysOfWeek?.map((v) => v.toJson()).toList(),
    };
  }
}

class DaysOfWeek {
  String? day;
  String? open;
  String? close;
  String? id;
  List<dynamic>? breaks;

  DaysOfWeek({this.day, this.open, this.close, this.id, this.breaks});

  DaysOfWeek.fromJson(dynamic json) {
    day = json['day'];
    open = json['open'];
    close = json['close'];
    id = json['_id'];
    breaks = json['breaks'] != null ? List<dynamic>.from(json['breaks']) : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'open': open,
      'close': close,
      '_id': id,
      'breaks': breaks,
    };
  }
}

class Location {
  List<num>? coordinates;
  String? type;

  Location({this.coordinates, this.type});

  Location.fromJson(dynamic json) {
    coordinates = json['coordinates'] != null
        ? json['coordinates'].cast<num>()
        : [];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    return {'coordinates': coordinates, 'type': type};
  }
}
