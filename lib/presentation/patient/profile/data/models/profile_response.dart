import '../../domain/entities/user_profile_entity.dart';

class ProfileResponse extends UserProfileEntity {
  ProfileResponse({
    required this.id,
    required this.userId,
    required this.address,
    required super.age,
    required this.gender,
    required this.height,
    required this.weight,
    required this.bloodType,
    required this.allergies,
    required this.chronicConditions,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.medications,
  }) : super(
         userName: userId?.name,
         userAddress: address,
         userGender: gender,
         userHeight: height,
         userWeight: weight,
         userBloodType: bloodType,
         allergiesList: allergies,
         chronicConditionsList: chronicConditions,
       );

  factory ProfileResponse.fromJson(dynamic json) {
    final userId = json['userId'] != null
        ? UserId.fromJson(json['userId'])
        : null;
    return ProfileResponse(
      id: json['_id']?.toString(),
      userId: userId,
      address: json['address']?.toString(),
      age: json['age'] as num?,
      gender: json['gender']?.toString(),
      height: json['height'] as num?,
      weight: json['weight'] as num?,
      bloodType: json['bloodType']?.toString(),
      allergies: _parseStringList(json['allergies']),
      chronicConditions: _parseStringList(json['chronicConditions']),
      createdAt: json['createdAt']?.toString(),
      updatedAt: json['updatedAt']?.toString(),
      v: json['__v'] as num?,
      medications: _parseDynamicList(json['medications']),
    );
  }

  final String? id;
  final UserId? userId;
  final String? address;
  final String? gender;
  final num? height;
  final num? weight;
  final String? bloodType;
  final List<String>? allergies;
  final List<String>? chronicConditions;
  final String? createdAt;
  final String? updatedAt;
  final num? v;
  final List<dynamic>? medications;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    if (userId != null) {
      map['userId'] = userId!.toJson();
    }
    map['address'] = address;
    map['age'] = age;
    map['gender'] = gender;
    map['height'] = height;
    map['weight'] = weight;
    map['bloodType'] = bloodType;
    map['allergies'] = allergies;
    map['chronicConditions'] = chronicConditions;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    map['medications'] = medications;
    return map;
  }

  static List<String> _parseStringList(dynamic value) {
    if (value is List) {
      return value.map((item) => item.toString()).toList();
    }
    return <String>[];
  }

  static List<dynamic> _parseDynamicList(dynamic value) {
    if (value is List) {
      return List<dynamic>.from(value);
    }
    return <dynamic>[];
  }
}

class UserId {
  UserId({this.id, this.name, this.email});

  UserId.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    email = json['email'];
  }

  String? id;
  String? name;
  String? email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['email'] = email;
    return map;
  }
}
