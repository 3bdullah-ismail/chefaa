class Medicines {
  Medicines({
      this.id, 
      this.medicineName, 
      this.genericName, 
      this.category, 
      this.dosageForm, 
      this.price, 
      this.quantity, 
      this.requiresPrescription,});

  Medicines.fromJson(dynamic json) {
    id = json['_id'];
    medicineName = json['medicineName'];
    genericName = json['genericName'];
    category = json['category'];
    dosageForm = json['dosageForm'];
    price = json['price'];
    quantity = json['quantity'];
    requiresPrescription = json['requiresPrescription'];
  }
  String? id;
  String? medicineName;
  String? genericName;
  String? category;
  String? dosageForm;
  num? price;
  num? quantity;
  bool? requiresPrescription;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['medicineName'] = medicineName;
    map['genericName'] = genericName;
    map['category'] = category;
    map['dosageForm'] = dosageForm;
    map['price'] = price;
    map['quantity'] = quantity;
    map['requiresPrescription'] = requiresPrescription;
    return map;
  }

}