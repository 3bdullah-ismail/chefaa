class PatientUpdate {
  PatientUpdate({
    this.id,
    this.userId,
    this.phoneNumber,
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
  });

  PatientUpdate.fromJson(dynamic json) {
    id = json['_id'];
    userId = json['userId'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    age = json['age'];
    gender = json['gender'];
    height = json['height'];
    weight = json['weight'];
    bloodType = json['bloodType'];
    allergies = json['allergies'] != null
        ? json['allergies'].cast<String>()
        : [];
    chronicConditions = json['chronicConditions'] != null
        ? json['chronicConditions'].cast<String>()
        : [];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }

  String? id;
  String? userId;
  String? phoneNumber;
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
    map['userId'] = userId;
    map['phoneNumber'] = phoneNumber;
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
