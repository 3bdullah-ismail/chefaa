class MostOrdered {
  MostOrdered({
      this.id, 
      this.medicineName, 
      this.category, 
      this.price, 
      this.requiresPrescription,});

  MostOrdered.fromJson(dynamic json) {
    id = json['_id'];
    medicineName = json['medicineName'];
    category = json['category'];
    price = json['price'];
    requiresPrescription = json['requiresPrescription'];
  }
  String? id;
  String? medicineName;
  String? category;
  num? price;
  bool? requiresPrescription;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['medicineName'] = medicineName;
    map['category'] = category;
    map['price'] = price;
    map['requiresPrescription'] = requiresPrescription;
    return map;
  }

}