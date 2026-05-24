class DoctorProfileEntity {
  final String? name;
  final String? specialization;
  final String? location;
  final String? imageUrl;
  final int? clinics;
  final double? rating;
  final int? reviews;

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

  bool isProfileCompleted() {
    return _hasValue(name) &&
        _hasValue(contactNumber) &&
        _hasValue(specialization) &&
        _hasValue(imageUrl) &&
        _hasValue(about);
  }

  List<String> getMissingRequiredFields() {
    final missing = <String>[];

    if (!_hasValue(name)) missing.add('Full name');
    if (!_hasValue(contactNumber)) missing.add('Phone number');
    if (!_hasValue(specialization)) missing.add('Specialization');
    if (!_hasValue(imageUrl)) missing.add('Profile image');
    if (!_hasValue(about)) missing.add('Bio');

    return missing;
  }

  static bool _hasValue(String? value) {
    return value != null && value.trim().isNotEmpty;
  }
}
