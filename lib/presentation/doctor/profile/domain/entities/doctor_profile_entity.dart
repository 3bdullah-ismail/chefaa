class DoctorProfileEntity {
  final String? name;
  final String? specialization;
  final String? location;
  final String? imageUrl;
  final int? clinics;
  final double? rating;
  final int? reviews;

  // Extended profile fields
  final int? yearsOfExperience;
  final String? about;
  final int? age;
  final String? paymentOption;
  final String? gender;
  final String? contactNumber;
  final List<dynamic>? degrees;
  final List<dynamic>? prePaymentNumbers;
  final num? clinicConsultationPrice;

  const DoctorProfileEntity({
    required this.name,
    required this.specialization,
    required this.location,
    required this.imageUrl,
    required this.clinics,
    required this.rating,
    required this.reviews,
    this.yearsOfExperience,
    this.about,
    this.age,
    this.paymentOption,
    this.gender,
    this.contactNumber,
    this.degrees,
    this.prePaymentNumbers,
    this.clinicConsultationPrice,
  });
}
