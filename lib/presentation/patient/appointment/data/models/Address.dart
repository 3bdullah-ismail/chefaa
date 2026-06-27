import 'Location.dart';

class Address {
  Address({
      this.location, 
      this.addressText,});

  Address.fromJson(dynamic json) {
    location = json['location'] != null ? Location.fromJson(json['location']) : null;
    addressText = json['addressText'];
  }
  Location? location;
  String? addressText;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (location != null) {
      map['location'] = location?.toJson();
    }
    map['addressText'] = addressText;
    return map;
  }

}