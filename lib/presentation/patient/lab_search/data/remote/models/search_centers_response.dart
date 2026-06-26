class SearchCentersResponse {
  final bool? success;
  final num? count;
  final bool? isAIRanked;
  final List<CenterModel>? centers;

  SearchCentersResponse({
    this.success,
    this.count,
    this.isAIRanked,
    this.centers,
  });

  factory SearchCentersResponse.fromJson(Map<String, dynamic> json) {
    return SearchCentersResponse(
      success: json['success'] as bool?,
      count: json['count'] as num?,
      isAIRanked: json['isAIRanked'] as bool?,
      centers: json['centers'] != null
          ? List<CenterModel>.from(
              (json['centers'] as List).map(
                (x) => CenterModel.fromJson(
                  x is Map<String, dynamic>
                      ? x
                      : Map<String, dynamic>.from(x as Map),
                ),
              ),
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'count': count,
      'isAIRanked': isAIRanked,
      'centers': centers?.map((e) => e.toJson()).toList(),
    };
  }
}

class CenterModel {
  final String? labId;
  final String? name;
  final String? facilityType;
  final num? rating;
  final num? distanceNum;
  final String? distance;
  final bool? homeServiceAvailable;
  final bool? insuranceAccepted;
  final num? minPrice;
  final String? badge;
  final String? nextSlot;
  final List<AvailableTagModel>? availableTags;

  CenterModel({
    this.labId,
    this.name,
    this.facilityType,
    this.rating,
    this.distanceNum,
    this.distance,
    this.homeServiceAvailable,
    this.insuranceAccepted,
    this.minPrice,
    this.badge,
    this.nextSlot,
    this.availableTags,
  });

  factory CenterModel.fromJson(Map<String, dynamic> json) {
    return CenterModel(
      labId: json['labId'] as String?,
      name: json['name'] as String?,
      facilityType: json['facilityType'] as String?,
      rating: json['rating'] as num?,
      distanceNum: json['distanceNum'] as num?,
      distance: json['distance'] as String?,
      homeServiceAvailable: json['homeServiceAvailable'] as bool?,
      insuranceAccepted: json['insuranceAccepted'] as bool?,
      minPrice: json['minPrice'] as num?,
      badge: json['badge'] as String?,
      nextSlot: json['nextSlot'] as String?,
      availableTags: json['availableTags'] != null
          ? List<AvailableTagModel>.from(
              (json['availableTags'] as List).map(
                (x) => AvailableTagModel.fromJson(
                  x is Map<String, dynamic>
                      ? x
                      : Map<String, dynamic>.from(x as Map),
                ),
              ),
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'labId': labId,
      'name': name,
      'facilityType': facilityType,
      'rating': rating,
      'distanceNum': distanceNum,
      'distance': distance,
      'homeServiceAvailable': homeServiceAvailable,
      'insuranceAccepted': insuranceAccepted,
      'minPrice': minPrice,
      'badge': badge,
      'nextSlot': nextSlot,
      'availableTags': availableTags?.map((e) => e.toJson()).toList(),
    };
  }
}

class AvailableTagModel {
  final String? name;
  final String? category;
  final bool? isPartner;

  AvailableTagModel({this.name, this.category, this.isPartner});

  factory AvailableTagModel.fromJson(Map<String, dynamic> json) {
    return AvailableTagModel(
      name: json['name'] as String?,
      category: json['category'] as String?,
      isPartner: json['isPartner'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'category': category, 'isPartner': isPartner};
  }
}
