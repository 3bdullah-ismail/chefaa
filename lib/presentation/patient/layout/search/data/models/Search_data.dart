import 'UserId.dart';
import 'Clinics.dart';

class SearchData {
  SearchData({
    this.id,
    this.userId,
    this.specialization,
    this.image,
    this.about,
    this.membershipPdf,
    this.degrees,
    this.preOnlineConsultation,
    this.clinics,
    this.paymentOption,
    this.prePaymentNumbers,
    this.rating,
    this.videoConsultationPrice,
    this.clinicConsultationPrice,
    this.reviews,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.gender,
  });

  SearchData.fromJson(dynamic json) {
    id = json['_id'];
    userId = json['userId'] != null ? UserId.fromJson(json['userId']) : null;
    specialization = json['specialization'];
    image = json['image'];
    about = json['about'];
    membershipPdf = json['membershipPdf'];
    if (json['degrees'] != null) {
      degrees = [];
      json['degrees'].forEach((v) {
        degrees?.add(Dynamic.fromJson(v));
      });
    }
    preOnlineConsultation = json['preOnlineConsultation'];
    if (json['clinics'] != null) {
      clinics = [];
      json['clinics'].forEach((v) {
        clinics?.add(Clinics.fromJson(v));
      });
    }
    paymentOption = json['paymentOption'];
    if (json['prePaymentNumbers'] != null) {
      prePaymentNumbers = [];
      json['prePaymentNumbers'].forEach((v) {
        prePaymentNumbers?.add(Dynamic.fromJson(v));
      });
    }
    rating = json['rating'];
    videoConsultationPrice = json['videoConsultationPrice'];
    clinicConsultationPrice = json['clinicConsultationPrice'];
    if (json['reviews'] != null) {
      reviews = [];
      json['reviews'].forEach((v) {
        reviews?.add(Dynamic.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
    gender = json['gender'];
  }
  String? id;
  UserId? userId;
  String? specialization;
  String? image;
  String? about;
  String? membershipPdf;
  List<dynamic>? degrees;
  bool? preOnlineConsultation;
  List<Clinics>? clinics;
  String? paymentOption;
  List<dynamic>? prePaymentNumbers;
  num? rating;
  num? videoConsultationPrice;
  num? clinicConsultationPrice;
  List<dynamic>? reviews;
  String? createdAt;
  String? updatedAt;
  num? v;
  String? gender;

  get Dynamic => null;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    if (userId != null) {
      map['userId'] = userId?.toJson();
    }
    map['specialization'] = specialization;
    map['image'] = image;
    map['about'] = about;
    map['membershipPdf'] = membershipPdf;
    if (degrees != null) {
      map['degrees'] = degrees?.map((v) => v.toJson()).toList();
    }
    map['preOnlineConsultation'] = preOnlineConsultation;
    if (clinics != null) {
      map['clinics'] = clinics?.map((v) => v.toJson()).toList();
    }
    map['paymentOption'] = paymentOption;
    if (prePaymentNumbers != null) {
      map['prePaymentNumbers'] = prePaymentNumbers
          ?.map((v) => v.toJson())
          .toList();
    }
    map['rating'] = rating;
    map['videoConsultationPrice'] = videoConsultationPrice;
    map['clinicConsultationPrice'] = clinicConsultationPrice;
    if (reviews != null) {
      map['reviews'] = reviews?.map((v) => v.toJson()).toList();
    }
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    map['gender'] = gender;
    return map;
  }
}
