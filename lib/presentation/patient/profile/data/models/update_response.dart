import 'package:chefaa/presentation/patient/profile/domain/entities/user_profile_entity.dart';

class UpdateResponse extends UserProfileEntity {
  final String? message;
  final UpdatedData? updatedData;

  UpdateResponse({this.message, this.updatedData})
    : super(
        userName: updatedData?.name,
        userAddress: null,
        age: updatedData?.age,
        userGender: updatedData?.gender,
        userHeight: updatedData?.height,
        userWeight: updatedData?.weight,
        userBloodType: '',
        allergiesList: null,
        chronicConditionsList: null,
      );

  factory UpdateResponse.fromJson(Map<String, dynamic> json) {
    final data = json['updatedData'] != null
        ? UpdatedData.fromJson(json['updatedData'])
        : null;

    return UpdateResponse(message: json['message'], updatedData: data);
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (updatedData != null) {
      map['updatedData'] = updatedData?.toJson();
    }
    return map;
  }
}

class UpdatedData {
  String? name;
  num? age;
  String? gender;
  num? height;
  num? weight;

  UpdatedData({this.name, this.age, this.gender, this.height, this.weight});

  UpdatedData.fromJson(dynamic json) {
    name = json['name'];
    age = json['age'];
    gender = json['gender'];
    height = json['height'];
    weight = json['weight'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['age'] = age;
    map['gender'] = gender;
    map['height'] = height;
    map['weight'] = weight;
    return map;
  }
}
