import 'package:chefaa/features/patient/profile/domain/entities/user_profile_entity.dart';

class UpdateMedicalInfoResponse extends UserProfileEntity {
  final String? message;
  final Patient? patient;

  UpdateMedicalInfoResponse({this.message, this.patient})
    : super(
        userName: null,
        userAddress: patient?.address,
        age: patient?.age,
        userGender: patient?.gender,
        userHeight: patient?.height,
        userWeight: patient?.weight,
        userBloodType: patient?.bloodType,
        allergiesList: patient?.allergies,
        chronicConditionsList: patient?.chronicConditions,
      );

  factory UpdateMedicalInfoResponse.fromJson(Map<String, dynamic> json) {
    return UpdateMedicalInfoResponse(
      message: json['message'],
      patient: json['patient'] != null
          ? Patient.fromJson(json['patient'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (patient != null) {
      map['patient'] = patient?.toJson();
    }
    return map;
  }
}

class Patient {
  String? id;
  String? userId;
  String? address;
  num? age;
  String? gender;
  num? height;
  num? weight;
  String? bloodType;
  List<String>? allergies;
  List<String>? chronicConditions;
  String? createdAt;
  String? updatedAt;
  num? v;
  List<dynamic>? medications;

  Patient({
    this.id,
    this.userId,
    this.address,
    this.age,
    this.gender,
    this.height,
    this.weight,
    this.bloodType,
    this.allergies,
    this.chronicConditions,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.medications,
  });

  Patient.fromJson(Map<String, dynamic> json) {
    id = json['_id']?.toString();
    userId = json['userId']?.toString();
    address = json['address'] is Map
        ? (json['address'] as Map)['addressText']?.toString()
        : json['address']?.toString();
    age = json['age'] as num?;
    gender = json['gender']?.toString();
    height = json['height'] as num?;
    weight = json['weight'] as num?;
    bloodType = json['bloodType']?.toString();

    allergies = json['allergies'] != null
        ? List<String>.from(json['allergies'])
        : null;
    chronicConditions = json['chronicConditions'] != null
        ? List<String>.from(json['chronicConditions'])
        : null;
    createdAt = json['createdAt']?.toString();
    updatedAt = json['updatedAt']?.toString();
    v = json['__v'] as num?;

    medications = json['medications'] != null
        ? List<dynamic>.from(json['medications'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['userId'] = userId;
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
}
