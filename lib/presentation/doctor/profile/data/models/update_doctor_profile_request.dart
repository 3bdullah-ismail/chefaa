/// Typed model that carries all update fields from the Cubit to the Repo.
/// Map construction is the responsibility of the DataSource layer.
class UpdateDoctorProfileRequest {
  final String? name;
  final String? specialization;
  final String? about;
  final int? age;
  final int? yearsOfExperience;
  final String? contactNumber;
  final num? clinicConsultationPrice;
  final String? gender;
  final String? paymentOption;
  final List<String>? degrees;
  final List<String>? prePaymentNumbers;

  const UpdateDoctorProfileRequest({
    this.name,
    this.specialization,
    this.about,
    this.age,
    this.yearsOfExperience,
    this.contactNumber,
    this.clinicConsultationPrice,
    this.gender,
    this.paymentOption,
    this.degrees,
    this.prePaymentNumbers,
  });
}
