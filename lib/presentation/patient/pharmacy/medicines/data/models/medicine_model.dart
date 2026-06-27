class MedicineModel {
  final String id;
  final String name;
  final String category;
  final num price;
  final int quantity;
  final bool requiresPrescription;

  const MedicineModel({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.quantity,
    required this.requiresPrescription,
  });

  factory MedicineModel.fromJson(Map<String, dynamic> json) {
    return MedicineModel(
      id: json['_id'] ?? '',
      name: json['medicineName'] ?? '',
      category: json['category'] ?? '',
      price: json['price'] ?? 0,
      quantity: json['quantity'] ?? 0,
      requiresPrescription: json['requiresPrescription'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'medicineName': name,
      'category': category,
      'price': price,
      'quantity': quantity,
      'requiresPrescription': requiresPrescription,
    };
  }
}
