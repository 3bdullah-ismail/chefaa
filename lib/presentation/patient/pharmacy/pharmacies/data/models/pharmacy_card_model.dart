class PharmacyCardModel {
  final String id;
  final String name;
  final String location;
  final String distance;
  final String deliveryTime;
  final int medicinesCount;
  final double rating;
  final int reviewsCount;
  final bool isOpen;
  final bool acceptsRx;

  const PharmacyCardModel({
    required this.id,
    required this.name,
    required this.location,
    required this.distance,
    required this.deliveryTime,
    required this.medicinesCount,
    required this.rating,
    required this.reviewsCount,
    required this.isOpen,
    required this.acceptsRx,
  });
}
