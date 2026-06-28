import '../../../pharmacy/pharmacies/data/models/pharmacy_profile_model.dart';

class AddressModel {
  final String? addressText;
  final LocationModel? location;

  AddressModel({
    this.addressText,
    this.location,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      addressText: json["addressText"],
      location: json["location"] != null
          ? LocationModel.fromJson(json["location"])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "addressText": addressText,
      "location": location?.toJson(),
    };
  }

  double? get longitude =>
      location?.coordinates.isNotEmpty == true
          ? location!.coordinates[0]
          : null;

  double? get latitude =>
      location?.coordinates.length == 2
          ? location!.coordinates[1]
          : null;
}