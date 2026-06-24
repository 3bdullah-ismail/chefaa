class ServiceModel {
  final String? id;
  final String? name;
  final String? category;
  final num? price;
  final String? estimatedTime;
  final String? sessionDuration;
  final String? instructions;
  final String? imageUrl;
  final bool? isActive;

  const ServiceModel({
    this.id,
    this.name,
    this.category,
    this.price,
    this.estimatedTime,
    this.sessionDuration,
    this.instructions,
    this.imageUrl,
    this.isActive,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['_id'] as String? ?? json['id'] as String?,
      name: json['name'] as String?,
      category: json['category'] as String?,
      price: json['price'] as num?,
      estimatedTime: json['estimatedTime'] as String?,
      sessionDuration: json['sessionDuration'] as String?,
      instructions: json['instructions'] as String?,
      imageUrl: json['imageUrl'] as String?,
      isActive: json['isActive'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) '_id': id,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (price != null) 'price': price,
      if (estimatedTime != null) 'estimatedTime': estimatedTime,
      if (sessionDuration != null) 'sessionDuration': sessionDuration,
      if (instructions != null) 'instructions': instructions,
      if (imageUrl != null) 'imageUrl': imageUrl,
      if (isActive != null) 'isActive': isActive,
    };
  }
}
