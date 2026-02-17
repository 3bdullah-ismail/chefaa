class Pharmacy {
  Pharmacy({this.id, this.name, this.role});

  Pharmacy.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    role = json['role'];
  }

  String? id;
  String? name;
  String? role;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['role'] = role;
    return map;
  }
}
