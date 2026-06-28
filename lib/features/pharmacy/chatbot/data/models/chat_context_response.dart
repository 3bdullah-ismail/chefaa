class ChatContextResponse {
  final bool? success;
  final ChatContextData? data;

  ChatContextResponse({this.success, this.data});

  factory ChatContextResponse.fromJson(Map<String, dynamic> json) {
    return ChatContextResponse(
      success: json['success'] as bool?,
      data: json['data'] != null
          ? ChatContextData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (success != null) 'success': success,
      if (data != null) 'data': data!.toJson(),
    };
  }
}

class ChatContextData {
  final PharmacyProfile? profile;
  final PharmacyInventory? inventory;
  final PharmacyOrders? orders;
  final PharmacyDeliveryMen? deliveryMen;
  final PharmacyFinancials? financials;

  ChatContextData({
    this.profile,
    this.inventory,
    this.orders,
    this.deliveryMen,
    this.financials,
  });

  factory ChatContextData.fromJson(Map<String, dynamic> json) {
    return ChatContextData(
      profile: json['profile'] != null
          ? PharmacyProfile.fromJson(json['profile'] as Map<String, dynamic>)
          : null,
      inventory: json['inventory'] != null
          ? PharmacyInventory.fromJson(json['inventory'] as Map<String, dynamic>)
          : null,
      orders: json['orders'] != null
          ? PharmacyOrders.fromJson(json['orders'] as Map<String, dynamic>)
          : null,
      deliveryMen: json['deliveryMen'] != null
          ? PharmacyDeliveryMen.fromJson(json['deliveryMen'] as Map<String, dynamic>)
          : null,
      financials: json['financials'] != null
          ? PharmacyFinancials.fromJson(json['financials'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (profile != null) 'profile': profile!.toJson(),
      if (inventory != null) 'inventory': inventory!.toJson(),
      if (orders != null) 'orders': orders!.toJson(),
      if (deliveryMen != null) 'deliveryMen': deliveryMen!.toJson(),
      if (financials != null) 'financials': financials!.toJson(),
    };
  }
}

class PharmacyProfile {
  final String? pharmacyName;
  final bool? openNow;
  final bool? deliveryAvailable;
  final String? visibilityStatus;
  final num? rating;
  final List<WorkingHour>? workingHours;
  final List<String>? deliveryArea;
  final List<dynamic>? cityDeliveryPrices;
  final List<dynamic>? paymentMethods;
  final String? deliveryTime;
  final num? commissionRate;

  PharmacyProfile({
    this.pharmacyName,
    this.openNow,
    this.deliveryAvailable,
    this.visibilityStatus,
    this.rating,
    this.workingHours,
    this.deliveryArea,
    this.cityDeliveryPrices,
    this.paymentMethods,
    this.deliveryTime,
    this.commissionRate,
  });

  factory PharmacyProfile.fromJson(Map<String, dynamic> json) {
    return PharmacyProfile(
      pharmacyName: json['pharmacyName'] as String?,
      openNow: json['openNow'] as bool?,
      deliveryAvailable: json['deliveryAvailable'] as bool?,
      visibilityStatus: json['visibilityStatus'] as String?,
      rating: json['rating'] as num?,
      workingHours: json['workingHours'] != null
          ? (json['workingHours'] as List)
              .map((item) => WorkingHour.fromJson(item as Map<String, dynamic>))
              .toList()
          : null,
      deliveryArea: json['deliveryArea'] != null
          ? (json['deliveryArea'] as List).map((e) => e.toString()).toList()
          : null,
      cityDeliveryPrices: json['cityDeliveryPrices'] as List<dynamic>?,
      paymentMethods: json['paymentMethods'] as List<dynamic>?,
      deliveryTime: json['deliveryTime'] as String?,
      commissionRate: json['commissionRate'] as num?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (pharmacyName != null) 'pharmacyName': pharmacyName,
      if (openNow != null) 'openNow': openNow,
      if (deliveryAvailable != null) 'deliveryAvailable': deliveryAvailable,
      if (visibilityStatus != null) 'visibilityStatus': visibilityStatus,
      if (rating != null) 'rating': rating,
      if (workingHours != null)
        'workingHours': workingHours!.map((item) => item.toJson()).toList(),
      if (deliveryArea != null) 'deliveryArea': deliveryArea,
      if (cityDeliveryPrices != null) 'cityDeliveryPrices': cityDeliveryPrices,
      if (paymentMethods != null) 'paymentMethods': paymentMethods,
      if (deliveryTime != null) 'deliveryTime': deliveryTime,
      if (commissionRate != null) 'commissionRate': commissionRate,
    };
  }
}

class WorkingHour {
  final String? days;
  final String? time;
  final String? id;

  WorkingHour({this.days, this.time, this.id});

  factory WorkingHour.fromJson(Map<String, dynamic> json) {
    return WorkingHour(
      days: json['days'] as String?,
      time: json['time'] as String?,
      id: json['_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (days != null) 'days': days,
      if (time != null) 'time': time,
      if (id != null) '_id': id,
    };
  }
}

class PharmacyInventory {
  final num? totalItems;
  final num? totalStockValue;
  final List<LowStockItem>? lowStockItems;
  final List<dynamic>? outOfStockItems;
  final List<dynamic>? expiringSoon;
  final Map<String, CategoryBreakdown>? categoriesBreakdown;
  final List<Medicine>? medicines;

  PharmacyInventory({
    this.totalItems,
    this.totalStockValue,
    this.lowStockItems,
    this.outOfStockItems,
    this.expiringSoon,
    this.categoriesBreakdown,
    this.medicines,
  });

  factory PharmacyInventory.fromJson(Map<String, dynamic> json) {
    return PharmacyInventory(
      totalItems: json['totalItems'] as num?,
      totalStockValue: json['totalStockValue'] as num?,
      lowStockItems: json['lowStockItems'] != null
          ? (json['lowStockItems'] as List)
              .map((item) => LowStockItem.fromJson(item as Map<String, dynamic>))
              .toList()
          : null,
      outOfStockItems: json['outOfStockItems'] as List<dynamic>?,
      expiringSoon: json['expiringSoon'] as List<dynamic>?,
      categoriesBreakdown: json['categoriesBreakdown'] != null
          ? (json['categoriesBreakdown'] as Map<String, dynamic>).map(
              (key, value) => MapEntry(
                key,
                CategoryBreakdown.fromJson(value as Map<String, dynamic>),
              ),
            )
          : null,
      medicines: json['medicines'] != null
          ? (json['medicines'] as List)
              .map((item) => Medicine.fromJson(item as Map<String, dynamic>))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (totalItems != null) 'totalItems': totalItems,
      if (totalStockValue != null) 'totalStockValue': totalStockValue,
      if (lowStockItems != null)
        'lowStockItems': lowStockItems!.map((item) => item.toJson()).toList(),
      if (outOfStockItems != null) 'outOfStockItems': outOfStockItems,
      if (expiringSoon != null) 'expiringSoon': expiringSoon,
      if (categoriesBreakdown != null)
        'categoriesBreakdown': categoriesBreakdown!.map((k, v) => MapEntry(k, v.toJson())),
      if (medicines != null)
        'medicines': medicines!.map((item) => item.toJson()).toList(),
    };
  }
}

class LowStockItem {
  final String? name;
  final num? quantity;
  final num? minThreshold;
  final String? category;

  LowStockItem({this.name, this.quantity, this.minThreshold, this.category});

  factory LowStockItem.fromJson(Map<String, dynamic> json) {
    return LowStockItem(
      name: json['name'] as String?,
      quantity: json['quantity'] as num?,
      minThreshold: json['minThreshold'] as num?,
      category: json['category'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (name != null) 'name': name,
      if (quantity != null) 'quantity': quantity,
      if (minThreshold != null) 'minThreshold': minThreshold,
      if (category != null) 'category': category,
    };
  }
}

class CategoryBreakdown {
  final num? count;
  final num? totalQuantity;

  CategoryBreakdown({this.count, this.totalQuantity});

  factory CategoryBreakdown.fromJson(Map<String, dynamic> json) {
    return CategoryBreakdown(
      count: json['count'] as num?,
      totalQuantity: json['totalQuantity'] as num?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (count != null) 'count': count,
      if (totalQuantity != null) 'totalQuantity': totalQuantity,
    };
  }
}

class Medicine {
  final String? name;
  final String? category;
  final num? price;
  final num? quantity;
  final num? minThreshold;
  final bool? inStock;
  final bool? requiresPrescription;
  final String? expiryDate;

  Medicine({
    this.name,
    this.category,
    this.price,
    this.quantity,
    this.minThreshold,
    this.inStock,
    this.requiresPrescription,
    this.expiryDate,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      name: json['name'] as String?,
      category: json['category'] as String?,
      price: json['price'] as num?,
      quantity: json['quantity'] as num?,
      minThreshold: json['minThreshold'] as num?,
      inStock: json['inStock'] as bool?,
      requiresPrescription: json['requiresPrescription'] as bool?,
      expiryDate: json['expiryDate'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (price != null) 'price': price,
      if (quantity != null) 'quantity': quantity,
      if (minThreshold != null) 'minThreshold': minThreshold,
      if (inStock != null) 'inStock': inStock,
      if (requiresPrescription != null) 'requiresPrescription': requiresPrescription,
      if (expiryDate != null) 'expiryDate': expiryDate,
    };
  }
}

class PharmacyOrders {
  final Map<String, dynamic>? statusCounts;
  final List<dynamic>? recentOrders;

  PharmacyOrders({this.statusCounts, this.recentOrders});

  factory PharmacyOrders.fromJson(Map<String, dynamic> json) {
    return PharmacyOrders(
      statusCounts: json['statusCounts'] as Map<String, dynamic>?,
      recentOrders: json['recentOrders'] as List<dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (statusCounts != null) 'statusCounts': statusCounts,
      if (recentOrders != null) 'recentOrders': recentOrders,
    };
  }
}

class PharmacyDeliveryMen {
  final DeliveryMenSummary? summary;
  final List<dynamic>? list;

  PharmacyDeliveryMen({this.summary, this.list});

  factory PharmacyDeliveryMen.fromJson(Map<String, dynamic> json) {
    return PharmacyDeliveryMen(
      summary: json['summary'] != null
          ? DeliveryMenSummary.fromJson(json['summary'] as Map<String, dynamic>)
          : null,
      list: json['list'] as List<dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (summary != null) 'summary': summary!.toJson(),
      if (list != null) 'list': list,
    };
  }
}

class DeliveryMenSummary {
  final num? available;
  final num? busy;
  final num? offline;

  DeliveryMenSummary({this.available, this.busy, this.offline});

  factory DeliveryMenSummary.fromJson(Map<String, dynamic> json) {
    return DeliveryMenSummary(
      available: json['Available'] as num?,
      busy: json['Busy'] as num?,
      offline: json['Offline'] as num?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (available != null) 'Available': available,
      if (busy != null) 'Busy': busy,
      if (offline != null) 'Offline': offline,
    };
  }
}

class PharmacyFinancials {
  final num? totalRevenue;
  final num? totalCommission;
  final num? totalNetEarnings;
  final num? currentDue;
  final String? paymentStatus;
  final num? lastPaidAmount;
  final String? lastPaidAt;
  final List<dynamic>? pendingPayments;
  final num? totalPending;

  PharmacyFinancials({
    this.totalRevenue,
    this.totalCommission,
    this.totalNetEarnings,
    this.currentDue,
    this.paymentStatus,
    this.lastPaidAmount,
    this.lastPaidAt,
    this.pendingPayments,
    this.totalPending,
  });

  factory PharmacyFinancials.fromJson(Map<String, dynamic> json) {
    return PharmacyFinancials(
      totalRevenue: json['totalRevenue'] as num?,
      totalCommission: json['totalCommission'] as num?,
      totalNetEarnings: json['totalNetEarnings'] as num?,
      currentDue: json['currentDue'] as num?,
      paymentStatus: json['paymentStatus'] as String?,
      lastPaidAmount: json['lastPaidAmount'] as num?,
      lastPaidAt: json['lastPaidAt'] as String?,
      pendingPayments: json['pendingPayments'] as List<dynamic>?,
      totalPending: json['totalPending'] as num?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (totalRevenue != null) 'totalRevenue': totalRevenue,
      if (totalCommission != null) 'totalCommission': totalCommission,
      if (totalNetEarnings != null) 'totalNetEarnings': totalNetEarnings,
      if (currentDue != null) 'currentDue': currentDue,
      if (paymentStatus != null) 'paymentStatus': paymentStatus,
      if (lastPaidAmount != null) 'lastPaidAmount': lastPaidAmount,
      if (lastPaidAt != null) 'lastPaidAt': lastPaidAt,
      if (pendingPayments != null) 'pendingPayments': pendingPayments,
      if (totalPending != null) 'totalPending': totalPending,
    };
  }
}
