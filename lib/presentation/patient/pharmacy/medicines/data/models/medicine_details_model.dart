class MedicineDetailsModel {
  final String id;
  final String name;
  final String category;
  final num price;
  final bool requiresPrescription;
  final bool inStock;
  final int availableQuantity;
  final MedicineInfoModel medicineInfo;
  final UsageInstructionsModel usageInstructions;
  final String pharmacyName;

  MedicineDetailsModel({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.requiresPrescription,
    required this.inStock,
    required this.availableQuantity,
    required this.medicineInfo,
    required this.usageInstructions,
    required this.pharmacyName,
  });

  factory MedicineDetailsModel.fromJson(Map<String, dynamic> json) {
    return MedicineDetailsModel(
      id: json['_id'] ?? '',
      name: json['medicineName'] ?? '',
      category: json['category'] ?? '',
      price: json['price'] ?? 0,
      requiresPrescription: json['requiresPrescription'] ?? false,
      inStock: json['inStock'] ?? false,
      availableQuantity: json['availableQuantity'] ?? 0,
      medicineInfo: MedicineInfoModel.fromJson(json['medicineInfo'] ?? {}),
      usageInstructions:
          UsageInstructionsModel.fromJson(json['usageInstructions'] ?? {}),
      pharmacyName: json['pharmacyName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'medicineName': name,
      'category': category,
      'price': price,
      'requiresPrescription': requiresPrescription,
      'inStock': inStock,
      'availableQuantity': availableQuantity,
      'medicineInfo': medicineInfo.toJson(),
      'usageInstructions': usageInstructions.toJson(),
      'pharmacyName': pharmacyName,
    };
  }
}

class MedicineInfoModel {
  final String brandName;
  final String concentration;
  final String manufacturer;
  final String prescription;
  final String shelf;

  MedicineInfoModel({
    required this.brandName,
    required this.concentration,
    required this.manufacturer,
    required this.prescription,
    required this.shelf,
  });

  factory MedicineInfoModel.fromJson(Map<String, dynamic> json) {
    return MedicineInfoModel(
      brandName: json['brandName'] ?? '',
      concentration: json['concentration'] ?? '',
      manufacturer: json['manufacturer'] ?? '',
      prescription: json['prescription'] ?? '',
      shelf: json['shelf'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'brandName': brandName,
      'concentration': concentration,
      'manufacturer': manufacturer,
      'prescription': prescription,
      'shelf': shelf,
    };
  }
}

class UsageInstructionsModel {
  final String indications;
  final String sideEffects;
  final String dosageInstructions;

  UsageInstructionsModel({
    required this.indications,
    required this.sideEffects,
    required this.dosageInstructions,
  });

  factory UsageInstructionsModel.fromJson(Map<String, dynamic> json) {
    return UsageInstructionsModel(
      indications: json['indications'] ?? '',
      sideEffects: json['sideEffects'] ?? '',
      dosageInstructions: json['dosageInstructions'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'indications': indications,
      'sideEffects': sideEffects,
      'dosageInstructions': dosageInstructions,
    };
  }
}
