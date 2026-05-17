import 'package:chefaa/presentation/doctor/profile/domain/entities/doctor_profile_entity.dart';

import 'clinics.dart';

class DoctorData extends DoctorProfileEntity {
  DoctorData({
    this.id,
    this.specialization,
    this.image,
    this.about,
    this.degrees,
    this.rating,
    this.paymentOption,
    this.prePaymentNumbers,
    this.clinicConsultationPrice,
    this.clinicsData,
    this.reviewsData,
    this.contactNumber,
    this.membershipPdf,
    this.name,
    this.email,
  }) : super(
         name: name,
         specialization: specialization,
         location: clinicsData != null && clinicsData.isNotEmpty
             ? clinicsData.first.address
             : '',
         imageUrl: image,
         clinics: clinicsData?.length ?? 0,
         rating: rating ?? 0.0,
         reviews: reviewsData?.length ?? 0,
       );

  DoctorData.fromJson(dynamic json)
    : super(
        name: json['name'],
        specialization: json['specialization'],
        location:
            (json['clinics'] != null && (json['clinics'] as List).isNotEmpty)
            ? json['clinics'][0]['address']
            : '',
        imageUrl: json['image'],
        clinics: json['clinics'] != null ? (json['clinics'] as List).length : 0,
        rating: json['rating']?.toDouble() ?? 0.0,
        reviews: json['reviews'] != null ? (json['reviews'] as List).length : 0,
      ) {
    id = json['_id'];
    specialization = json['specialization'];
    image = json['image'];
    about = json['about'];
    if (json['degrees'] != null) {
      degrees = [];
      json['degrees'].forEach((v) {
        degrees?.add(v);
      });
    }
    rating = json['rating']?.toDouble();
    paymentOption = json['paymentOption'];
    if (json['prePaymentNumbers'] != null) {
      prePaymentNumbers = [];
      json['prePaymentNumbers'].forEach((v) {
        prePaymentNumbers?.add(v);
      });
    }
    clinicConsultationPrice = json['clinicConsultationPrice'];
    if (json['clinics'] != null) {
      clinicsData = [];
      json['clinics'].forEach((v) {
        clinicsData?.add(Clinics.fromJson(v));
      });
    }
    if (json['reviews'] != null) {
      reviewsData = [];
      json['reviews'].forEach((v) {
        reviewsData?.add(v);
      });
    }
    contactNumber = json['contactNumber'];
    membershipPdf = json['membershipPdf'];
    name = json['name'];
    email = json['email'];
  }

  String? id;
  @override
  String? specialization;
  String? image;
  String? about;
  List<dynamic>? degrees;
  @override
  double? rating;
  String? paymentOption;
  List<dynamic>? prePaymentNumbers;
  num? clinicConsultationPrice;
  List<Clinics>? clinicsData;
  List<dynamic>? reviewsData;
  String? contactNumber;
  String? membershipPdf;
  @override
  String? name;
  String? email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['specialization'] = specialization;
    map['image'] = image;
    map['about'] = about;
    if (degrees != null) {
      map['degrees'] = degrees;
    }
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
