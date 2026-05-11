class Patient {
  Patient({
    this.address,
    this.isBlocked,
    this.blockedUntil,
    this.blockReason,
    this.id,
    this.userId,
    this.age,
    this.gender,
    this.height,
    this.weight,
    this.bloodType,
    this.allergies,
    this.chronicConditions,
    this.medications,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  Patient.fromJson(dynamic json) {
    address = json['address'] is Map
        ? Map<String, dynamic>.from(json['address'] as Map)
        : null;
    isBlocked = json['isBlocked'];
    blockedUntil = json['blockedUntil'];
    blockReason = json['blockReason'];
    id = json['_id'];
    userId = json['userId'];
    age = json['age'];
    gender = json['gender'];
    height = json['height'];
    weight = json['weight'];
    bloodType = json['bloodType'];
    allergies = (json['allergies'] as List?)?.map((e) => e.toString()).toList();
    chronicConditions = (json['chronicConditions'] as List?)
        ?.map((e) => e.toString())
        .toList();
    medications = (json['medications'] as List?)?.toList();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }

  Map<String, dynamic>? address;
  bool? isBlocked;
  dynamic blockedUntil;
  dynamic blockReason;
  String? id;
  String? userId;
  num? age;
  String? gender;
  num? height;
  num? weight;
  String? bloodType;
  List<String>? allergies;
  List<String>? chronicConditions;
  List<dynamic>? medications;
  String? createdAt;
  String? updatedAt;
  num? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address'] = address;
    map['isBlocked'] = isBlocked;
    map['blockedUntil'] = blockedUntil;
    map['blockReason'] = blockReason;
    map['_id'] = id;
    map['userId'] = userId;
    map['age'] = age;
    map['gender'] = gender;
    map['height'] = height;
    map['weight'] = weight;
    map['bloodType'] = bloodType;
    map['allergies'] = allergies;
    map['chronicConditions'] = chronicConditions;
    map['medications'] = medications;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }
}
