class LocationModel {
  final String? type;
  final List<double> coordinates;

  LocationModel({
    this.type,
    required this.coordinates,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      type: json["type"],
      coordinates: (json["coordinates"] as List)
          .map((e) => (e as num).toDouble())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "coordinates": coordinates,
    };
  }
}