import 'package:chefaa/features/doctor/profile/domain/entities/doctor_profile_entity.dart';

class UpdateDoctorProfileResponse {
  final String? message;
  final UpdatedDoctorData? doctor;

  UpdateDoctorProfileResponse({this.message, this.doctor});

  factory UpdateDoctorProfileResponse.fromJson(Map<String, dynamic> json) {
    return UpdateDoctorProfileResponse(
      message: json['message'] as String?,
      doctor: json['doctor'] != null
          ? UpdatedDoctorData.fromJson(json['doctor'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'message': message, if (doctor != null) 'doctor': doctor?.toJson()};
  }
}

class UpdatedDoctorData extends DoctorProfileEntity {
  final String? id;
  final String? userId;
  final String? image;
  final String? membershipPdf;
  final List<String>? clinicsData;
  final List<dynamic>? reviewsData;
  final String? createdAt;
  final String? updatedAt;
  final int? v;

  UpdatedDoctorData({
    this.id,
    this.userId,
    super.specialization,
    super.contactNumber,
    this.image,
    super.about,
    this.membershipPdf,
    super.degrees,
    this.clinicsData,
    super.paymentOption,
    super.prePaymentNumbers,
    super.rating,
    super.clinicConsultationPrice,
    this.reviewsData,
    this.createdAt,
    this.updatedAt,
    this.v,
    super.gender,
    super.age,
    super.yearsOfExperience,
  }) : super(
         name: null,
         location: null,
         imageUrl: image,
         clinics: clinicsData?.length ?? 0,
         reviews: reviewsData?.length ?? 0,
       );

  factory UpdatedDoctorData.fromJson(Map<String, dynamic> json) {
    return UpdatedDoctorData(
      id: json['_id'] as String?,
      userId: json['userId'] as String?,
      specialization: json['specialization'] as String?,
      contactNumber: json['contactNumber'] as String?,
      image: json['image'] as String?,
      about: json['about'] as String?,
      membershipPdf: json['membershipPdf'] as String?,
      degrees: json['degrees'] != null
          ? List<dynamic>.from(json['degrees'])
          : null,
      clinicsData: json['clinics'] != null
          ? List<String>.from(json['clinics'])
          : null,
      paymentOption: json['paymentOption'] as String?,
      prePaymentNumbers: json['prePaymentNumbers'] != null
          ? List<dynamic>.from(json['prePaymentNumbers'])
          : null,
      rating: (json['rating'] as num?)?.toDouble(),
      clinicConsultationPrice: json['clinicConsultationPrice'] as num?,
      reviewsData: json['reviews'] != null
          ? List<dynamic>.from(json['reviews'])
          : null,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      v: json['__v'] as int?,
      gender: json['gender'] as String?,
      age: json['age'] as int?,
      yearsOfExperience: json['yearsOfExperience'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'specialization': specialization,
      'contactNumber': contactNumber,
      'image': image,
      'about': about,
      'membershipPdf': membershipPdf,
      'degrees': degrees,
      'clinics': clinicsData,
      'paymentOption': paymentOption,
      'prePaymentNumbers': prePaymentNumbers,
      'rating': rating,
      'clinicConsultationPrice': clinicConsultationPrice,
      'reviews': reviewsData,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
      'gender': gender,
      'age': age,
      'yearsOfExperience': yearsOfExperience,
    };
  }
}
