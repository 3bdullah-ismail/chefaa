import '../../domain/entities/doctor_profile_entity.dart';

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
  @override
  final String? specialization;
  @override
  final String? contactNumber;
  final String? image;
  @override
  final String? about;
  final String? membershipPdf;
  @override
  final List<dynamic>? degrees;
  final List<String>? clinicsData;
  @override
  final String? paymentOption;
  @override
  final List<dynamic>? prePaymentNumbers;
  @override
  final double? rating;
  @override
  final num? clinicConsultationPrice;
  final List<dynamic>? reviewsData;
  final String? createdAt;
  final String? updatedAt;
  final int? v;
  @override
  final String? gender;

  @override
  final int? age;
  @override
  final int? yearsOfExperience;

  UpdatedDoctorData({
    this.id,
    this.userId,
    this.specialization,
    this.contactNumber,
    this.image,
    this.about,
    this.membershipPdf,
    this.degrees,
    this.clinicsData,
    this.paymentOption,
    this.prePaymentNumbers,
    this.rating,
    this.clinicConsultationPrice,
    this.reviewsData,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.gender,
    this.age,
    this.yearsOfExperience,
  }) : super(
         name: null,
         specialization: specialization,
         location: null,
         imageUrl: image,
         clinics: clinicsData?.length ?? 0,
         rating: rating,
         reviews: reviewsData?.length ?? 0,
         about: about,
         age: age,
         yearsOfExperience: yearsOfExperience,
         paymentOption: paymentOption,
         gender: gender,
         contactNumber: contactNumber,
         degrees: degrees,
         prePaymentNumbers: prePaymentNumbers,
         clinicConsultationPrice: clinicConsultationPrice,
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
