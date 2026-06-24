import 'package:chefaa/presentation/doctor/profile/domain/entities/doctor_profile_entity.dart';

import 'clinics.dart';

class DoctorData extends DoctorProfileEntity {
  DoctorData({
    this.id,
    super.specialization,
    super.age,
    super.yearsOfExperience,
    this.image,
    super.about,
    super.degrees,
    super.gender,
    double? rating,
    super.paymentOption,
    super.prePaymentNumbers,
    super.clinicConsultationPrice,
    this.clinicsData,
    this.reviewsData,
    super.contactNumber,
    this.membershipPdf,
    super.name,
    this.email,
  }) : super(
         location: clinicsData != null && clinicsData.isNotEmpty
             ? clinicsData.first.address ?? ''
             : '',
         imageUrl: image,
         clinics: clinicsData?.length ?? 0,
         rating: rating ?? 0.0,
         reviews: reviewsData?.length ?? 0,
       );

  DoctorData.fromJson(dynamic json)
    : this(
        id: json['_id'] as String?,
        specialization: json['specialization'] as String?,
        age: json['age'] as int?,
        yearsOfExperience: json['yearsOfExperience'] as int?,
        image: json['image'] as String?,
        about: json['about'] as String?,
        degrees: json['degrees'] != null
            ? List<dynamic>.from(json['degrees'] as List)
            : null,
        gender: json['gender'] as String?,
        rating: (json['rating'] as num?)?.toDouble(),
        paymentOption: json['paymentOption'] as String?,
        prePaymentNumbers: json['prePaymentNumbers'] != null
            ? List<dynamic>.from(json['prePaymentNumbers'] as List)
            : null,
        clinicConsultationPrice: json['clinicConsultationPrice'] as num?,
        clinicsData: json['clinics'] != null
            ? (json['clinics'] as List).map((v) => Clinics.fromJson(v)).toList()
            : null,
        reviewsData: json['reviews'] != null
            ? List<dynamic>.from(json['reviews'] as List)
            : null,
        contactNumber: json['contactNumber'] as String?,
        membershipPdf: json['membershipPdf'] as String?,
        name: json['name'] as String?,
        email: json['email'] as String?,
      );

  // Only fields NOT present in DoctorProfileEntity
  String? id;
  String? image;
  List<Clinics>? clinicsData;
  List<dynamic>? reviewsData;
  String? membershipPdf;
  String? email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['specialization'] = specialization;
    map['age'] = age;
    map['yearsOfExperience'] = yearsOfExperience;
    map['image'] = image;
    map['about'] = about;
    if (degrees != null) {
      map['degrees'] = degrees;
    }
    map['gender'] = gender;
    map['rating'] = rating;
    map['paymentOption'] = paymentOption;
    if (prePaymentNumbers != null) {
      map['prePaymentNumbers'] = prePaymentNumbers;
    }
    map['clinicConsultationPrice'] = clinicConsultationPrice;
    if (clinicsData != null) {
      map['clinics'] = clinicsData?.map((v) => v.toJson()).toList();
    }
    if (reviewsData != null) {
      map['reviews'] = reviewsData;
    }
    map['contactNumber'] = contactNumber;
    map['membershipPdf'] = membershipPdf;
    map['name'] = name;
    map['email'] = email;
    return map;
  }
}
