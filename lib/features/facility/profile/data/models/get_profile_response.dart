class GetProfileResponse {
  final bool? success;
  final ProfileData? profileData;

  GetProfileResponse({this.success, this.profileData});

  factory GetProfileResponse.fromJson(Map<String, dynamic> json) {
    return GetProfileResponse(
      success: json['success'] as bool?,
      profileData: json['profileData'] != null
          ? ProfileData.fromJson(json['profileData'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (success != null) 'success': success,
      if (profileData != null) 'profileData': profileData!.toJson(),
    };
  }
}

class ProfileData {
  final String? id;
  final String? name;
  final String? phoneNumber;
  final String? facilityType;
  final num? rating;
  final num? servicesCount;
  final AiVisibility? aiVisibility;
  final ProfileSettings? settings;
  final List<AddressData>? addresses;
  final WorkingHours? workingHours;
  final List<String>? paymentmethod;

  ProfileData({
    this.id,
    this.name,
    this.phoneNumber,
    this.facilityType,
    this.rating,
    this.servicesCount,
    this.aiVisibility,
    this.settings,
    this.addresses,
    this.workingHours,
    this.paymentmethod,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      id: json['id'] as String?,
      name: json['name'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      facilityType: json['facilityType'] as String?,
      rating: json['rating'] as num?,
      servicesCount: json['servicesCount'] as num?,
      aiVisibility: json['aiVisibility'] != null
          ? AiVisibility.fromJson(json['aiVisibility'] as Map<String, dynamic>)
          : null,
      settings: json['settings'] != null
          ? ProfileSettings.fromJson(json['settings'] as Map<String, dynamic>)
          : ProfileSettings.fromJson(json),
      addresses: (json['addresses'] as List<dynamic>?)
          ?.map((e) => AddressData.fromJson(e as Map<String, dynamic>))
          .toList(),
      workingHours: json['workingHours'] != null
          ? WorkingHours.fromJson(json['workingHours'] as Map<String, dynamic>)
          : null,
      paymentmethod:
          (json['paymentmethod'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          (json['paymentMethod'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          (json['paymentMethods'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (phoneNumber != null) 'phoneNumber': phoneNumber,
      if (facilityType != null) 'facilityType': facilityType,
      if (rating != null) 'rating': rating,
      if (servicesCount != null) 'servicesCount': servicesCount,
      if (aiVisibility != null) 'aiVisibility': aiVisibility!.toJson(),
      if (settings != null) 'settings': settings!.toJson(),
      if (addresses != null)
        'addresses': addresses!.map((e) => e.toJson()).toList(),
      if (workingHours != null) 'workingHours': workingHours!.toJson(),
      if (paymentmethod != null) 'paymentmethod': paymentmethod,
    };
  }
}

class WorkingHours {
  final num? open;
  final num? close;

  WorkingHours({this.open, this.close});

  factory WorkingHours.fromJson(Map<String, dynamic> json) {
    return WorkingHours(
      open: json['open'] as num?,
      close: json['close'] as num?,
    );
  }

  Map<String, dynamic> toJson() {
    return {if (open != null) 'open': open, if (close != null) 'close': close};
  }
}

class AddressData {
  final String? addressText;
  final int? floor;
  final AddressLocation? location;

  AddressData({this.addressText, this.floor, this.location});

  factory AddressData.fromJson(Map<String, dynamic> json) {
    return AddressData(
      addressText: json['addressText'] as String?,
      floor: json['floor'] as int?,
      location: json['location'] != null
          ? AddressLocation.fromJson(json['location'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (addressText != null) 'addressText': addressText,
      if (floor != null) 'floor': floor,
      if (location != null) 'location': location!.toJson(),
    };
  }
}

class AddressLocation {
  final String? type;
  final List<double>? coordinates;

  AddressLocation({this.type, this.coordinates});

  factory AddressLocation.fromJson(Map<String, dynamic> json) {
    return AddressLocation(
      type: json['type'] as String?,
      coordinates: (json['coordinates'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (type != null) 'type': type,
      if (coordinates != null) 'coordinates': coordinates,
    };
  }
}

class AiVisibility {
  final String? status;
  final String? text;
  final String? referrals;

  AiVisibility({this.status, this.text, this.referrals});

  factory AiVisibility.fromJson(Map<String, dynamic> json) {
    return AiVisibility(
      status: json['status'] as String?,
      text: json['text'] as String?,
      referrals: json['referrals'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (status != null) 'status': status,
      if (text != null) 'text': text,
      if (referrals != null) 'referrals': referrals,
    };
  }
}

class ProfileSettings {
  final bool? homeSampleCollection;
  final bool? aiRecommendations;
  final bool? insuranceAccepted;

  ProfileSettings({
    this.homeSampleCollection,
    this.aiRecommendations,
    this.insuranceAccepted,
  });

  factory ProfileSettings.fromJson(Map<String, dynamic> json) {
    return ProfileSettings(
      homeSampleCollection: json['homeSampleCollection'] as bool?,
      aiRecommendations: json['aiRecommendations'] as bool?,
      insuranceAccepted: json['insuranceAccepted'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (homeSampleCollection != null)
        'homeSampleCollection': homeSampleCollection,
      if (aiRecommendations != null) 'aiRecommendations': aiRecommendations,
      if (insuranceAccepted != null) 'insuranceAccepted': insuranceAccepted,
    };
  }
}
