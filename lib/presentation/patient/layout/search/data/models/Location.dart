class Location {
  Location({this.coordinates, this.type});

  Location.fromJson(dynamic json) {
    coordinates = json['coordinates'] != null
        ? json['coordinates'].cast<num>()
        : [];
    type = json['type'];
  }
  List<num>? coordinates;
  String? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['coordinates'] = coordinates;
    map['type'] = type;
    return map;
  }
}
