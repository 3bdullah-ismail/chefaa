class DoctorModel {
  final String name;
  final String specialty;
  final String rating;
  final String ratingCount;
  final String price;
  final String? imageUrl;
  final String? gender;
  final String? location;
  final List<DateTime> availableDays;

  DoctorModel({
    required this.name,
    required this.specialty,
    required this.rating,
    required this.ratingCount,
    required this.price,
    this.imageUrl,
    this.gender,
    this.location,
    required this.availableDays,
  });
}
