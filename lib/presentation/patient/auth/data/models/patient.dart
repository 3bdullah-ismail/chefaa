class Patient {
  Patient({
      this.id, 
      this.name, 
      this.role,});

  Patient.fromJson(dynamic json) {
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