
import '../../domain/entities/user_profile_entity.dart';

class ProfileResponse extends UserProfileEntity {
  ProfileResponse({
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
  }) : super(
         userName: userId?.name ?? '',
         userAddress: address ?? '',
         age: age ?? 1,
         userGender: gender ?? 'male',
         userHeight: height ?? 0.0,
         userWeight: weight ?? 0.0,
         userBloodType: bloodType ?? 'O+',
         allergiesList: allergies ?? [],
         chronicConditionsList: chronicConditions ?? [],
       );

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
      id: json['_id'],
      userId: json['userId'] != null ? UserId.fromJson(json['userId']) : null,
      address: json['address'],
      age: json['age'] != null ? int.tryParse(json['age'].toString()) : null,
      gender: json['gender'],
      height: json['height'],
      weight: json['weight'],
      bloodType: json['bloodType'],
      allergies: json['allergies'] != null
          ? List<String>.from(json['allergies'])
          : [],
      chronicConditions: json['chronicConditions'] != null
          ? List<String>.from(json['chronicConditions'])
          : [],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }
  String? id;
  UserId? userId;
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

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    if (userId != null) {
      map['userId'] = userId?.toJson();
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
    return map;
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
