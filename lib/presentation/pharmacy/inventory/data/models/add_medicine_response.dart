class AddMedicineResponse {
  final bool? success;
  final String? message;
  final MedicineData? data;

  AddMedicineResponse({this.success, this.message, this.data});

  factory AddMedicineResponse.fromJson(Map<String, dynamic> json) {
    return AddMedicineResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? MedicineData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (success != null) 'success': success,
      if (message != null) 'message': message,
      if (data != null) 'data': data!.toJson(),
    };
  }
}

class MedicineData {
  final String? pharmacyId;
  final String? medicineName;
  final String? concentration;
  final String? category;
  final String? manufacturer;
  final num? price;
  final num? quantity;
  final num? minThreshold;
  final bool? inStock;
  final bool? requiresPrescription;
  final String? expiryDate;
  final String? image;
  final String? id;
  final String? createdAt;
  final String? updatedAt;

  MedicineData({
    this.pharmacyId,
    this.medicineName,
    this.concentration,
    this.category,
    this.manufacturer,
    this.price,
    this.quantity,
    this.minThreshold,
    this.inStock,
    this.requiresPrescription,
    this.expiryDate,
    this.image,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  factory MedicineData.fromJson(Map<String, dynamic> json) {
    return MedicineData(
      pharmacyId: json['pharmacyId'] as String?,
      medicineName: json['medicineName'] as String?,
      concentration: json['concentration'] as String?,
      category: json['category'] as String?,
      manufacturer: json['manufacturer'] as String?,
      price: json['price'] as num?,
      quantity: json['quantity'] as num?,
      minThreshold: json['minThreshold'] as num?,
      inStock: json['inStock'] as bool?,
      requiresPrescription: json['requiresPrescription'] as bool?,
      expiryDate: json['expiryDate'] as String?,
      image: json['image'] as String?,
      id: json['_id'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (pharmacyId != null) 'pharmacyId': pharmacyId,
      if (medicineName != null) 'medicineName': medicineName,
      if (concentration != null) 'concentration': concentration,
      if (category != null) 'category': category,
      if (manufacturer != null) 'manufacturer': manufacturer,
      if (price != null) 'price': price,
      if (quantity != null) 'quantity': quantity,
      if (minThreshold != null) 'minThreshold': minThreshold,
      if (inStock != null) 'inStock': inStock,
      if (requiresPrescription != null) 'requiresPrescription': requiresPrescription,
      if (expiryDate != null) 'expiryDate': expiryDate,
      if (image != null) 'image': image,
      if (id != null) '_id': id,
      if (createdAt != null) 'createdAt': createdAt,
      if (updatedAt != null) 'updatedAt': updatedAt,
    };
  }
}
