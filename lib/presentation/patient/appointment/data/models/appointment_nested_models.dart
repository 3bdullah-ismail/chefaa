class AppointmentPatientUserModel {
  final String? id;
  final String? name;
  final String? email;
  final String? phoneNumber;

  const AppointmentPatientUserModel({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
  });

  factory AppointmentPatientUserModel.fromJson(dynamic json) {
    return AppointmentPatientUserModel(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
    };
  }
}

class AppointmentPatientModel {
  final String? id;
  final Map<String, dynamic>? address;
  final bool? isBlocked;
  final AppointmentPatientUserModel? userId;
  final int? age;
  final String? gender;
  final num? height;
  final num? weight;
  final String? bloodType;
  final List<dynamic>? allergies;
  final List<dynamic>? chronicConditions;

  const AppointmentPatientModel({
    this.id,
    this.address,
    this.isBlocked,
    this.userId,
    this.age,
    this.gender,
    this.height,
    this.weight,
    this.bloodType,
    this.allergies,
    this.chronicConditions,
  });

  factory AppointmentPatientModel.fromJson(dynamic json) {
    if (json == null) return const AppointmentPatientModel();

    final userJson = json['userId'];
    return AppointmentPatientModel(
      id: json['_id'],
      address: json['address'] as Map<String, dynamic>?,
      isBlocked: json['isBlocked'],
      userId: userJson != null
          ? AppointmentPatientUserModel.fromJson(userJson)
          : null,
      age: json['age'],
      gender: json['gender'],
      height: json['height'],
      weight: json['weight'],
      bloodType: json['bloodType'],
      allergies: json['allergies'] is List ? json['allergies'] : [],
      chronicConditions: json['chronicConditions'] is List
          ? json['chronicConditions']
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'address': address,
      'isBlocked': isBlocked,
      'userId': userId?.toJson(),
      'age': age,
      'gender': gender,
      'height': height,
      'weight': weight,
      'bloodType': bloodType,
      'allergies': allergies,
      'chronicConditions': chronicConditions,
    };
  }
}

class AppointmentDoctorModel {
  final String? id;
  final String? specialization;

  const AppointmentDoctorModel({this.id, this.specialization});

  factory AppointmentDoctorModel.fromJson(dynamic json) {
    if (json == null) return const AppointmentDoctorModel();
    return AppointmentDoctorModel(
      id: json['_id'],
      specialization: json['specialization'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'_id': id, 'specialization': specialization};
  }
}

class AppointmentClinicModel {
  final String? id;
  final String? name;
  final String? address;
  final num? price;

  const AppointmentClinicModel({this.id, this.name, this.address, this.price});

  factory AppointmentClinicModel.fromJson(dynamic json) {
    if (json == null) return const AppointmentClinicModel();
    return AppointmentClinicModel(
      id: json['_id'],
      name: json['name'],
      address: json['address'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'_id': id, 'name': name, 'address': address, 'price': price};
  }
}
