class TrackOrderResponse {
  final bool success;
  final TrackOrderData? data;

  TrackOrderResponse({
    required this.success,
    this.data,
  });

  factory TrackOrderResponse.fromJson(Map<String, dynamic> json) {
    return TrackOrderResponse(
      success: json['success'] ?? false,
      data: json['data'] != null ? TrackOrderData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.toJson(),
    };
  }
}

class TrackOrderData {
  final String orderNumber;
  final String orderStatus;
  final RiderInfo? riderInfo;
  final StatusTimeline? statusTimeline;
  final OrderContents? orderContents;

  TrackOrderData({
    required this.orderNumber,
    required this.orderStatus,
    this.riderInfo,
    this.statusTimeline,
    this.orderContents,
  });

  factory TrackOrderData.fromJson(Map<String, dynamic> json) {
    return TrackOrderData(
      orderNumber: json['orderNumber'] ?? '',
      orderStatus: json['orderStatus'] ?? '',
      riderInfo: json['riderInfo'] != null ? RiderInfo.fromJson(json['riderInfo']) : null,
      statusTimeline: json['statusTimeline'] != null ? StatusTimeline.fromJson(json['statusTimeline']) : null,
      orderContents: json['orderContents'] != null ? OrderContents.fromJson(json['orderContents']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderNumber': orderNumber,
      'orderStatus': orderStatus,
      'riderInfo': riderInfo?.toJson(),
      'statusTimeline': statusTimeline?.toJson(),
      'orderContents': orderContents?.toJson(),
    };
  }
}

class RiderInfo {
  final String name;
  final String phoneNumber;
  final num rating;

  RiderInfo({
    required this.name,
    required this.phoneNumber,
    required this.rating,
  });

  factory RiderInfo.fromJson(Map<String, dynamic> json) {
    return RiderInfo(
      name: json['name'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      rating: json['rating'] ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'rating': rating,
    };
  }
}

class StatusTimeline {
  final TimelineStep? orderConfirmed;
  final TimelineStep? pharmacyPreparing;
  final TimelineStep? riderPickedUp;
  final TimelineStep? onTheWay;

  StatusTimeline({
    this.orderConfirmed,
    this.pharmacyPreparing,
    this.riderPickedUp,
    this.onTheWay,
  });

  factory StatusTimeline.fromJson(Map<String, dynamic> json) {
    return StatusTimeline(
      orderConfirmed: json['orderConfirmed'] != null ? TimelineStep.fromJson(json['orderConfirmed']) : null,
      pharmacyPreparing: json['pharmacyPreparing'] != null ? TimelineStep.fromJson(json['pharmacyPreparing']) : null,
      riderPickedUp: json['riderPickedUp'] != null ? TimelineStep.fromJson(json['riderPickedUp']) : null,
      onTheWay: json['onTheWay'] != null ? TimelineStep.fromJson(json['onTheWay']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderConfirmed': orderConfirmed?.toJson(),
      'pharmacyPreparing': pharmacyPreparing?.toJson(),
      'riderPickedUp': riderPickedUp?.toJson(),
      'onTheWay': onTheWay?.toJson(),
    };
  }
}

class TimelineStep {
  final String title;
  final String description;
  final String? time;
  final bool isCompleted;

  TimelineStep({
    required this.title,
    required this.description,
    this.time,
    required this.isCompleted,
  });

  factory TimelineStep.fromJson(Map<String, dynamic> json) {
    return TimelineStep(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      time: json['time'],
      isCompleted: json['isCompleted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'time': time,
      'isCompleted': isCompleted,
    };
  }
}

class OrderContents {
  final List<OrderItem> items;
  final OrderSummary? summary;

  OrderContents({
    required this.items,
    this.summary,
  });

  factory OrderContents.fromJson(Map<String, dynamic> json) {
    return OrderContents(
      items: json['items'] != null
          ? (json['items'] as List).map((i) => OrderItem.fromJson(i)).toList()
          : [],
      summary: json['summary'] != null ? OrderSummary.fromJson(json['summary']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((i) => i.toJson()).toList(),
      'summary': summary?.toJson(),
    };
  }
}

class OrderItem {
  final String medicineId;
  final String medicineName;
  final int quantity;
  final num price;
  final num itemTotal;

  OrderItem({
    required this.medicineId,
    required this.medicineName,
    required this.quantity,
    required this.price,
    required this.itemTotal,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      medicineId: json['medicineId'] ?? '',
      medicineName: json['medicineName'] ?? '',
      quantity: json['quantity'] ?? 0,
      price: json['price'] ?? 0,
      itemTotal: json['itemTotal'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'medicineId': medicineId,
      'medicineName': medicineName,
      'quantity': quantity,
      'price': price,
      'itemTotal': itemTotal,
    };
  }
}

class OrderSummary {
  final num subtotal;
  final num deliveryFee;
  final num discount;
  final num totalPrice;
  final String paymentMethod;

  OrderSummary({
    required this.subtotal,
    required this.deliveryFee,
    required this.discount,
    required this.totalPrice,
    required this.paymentMethod,
  });

  factory OrderSummary.fromJson(Map<String, dynamic> json) {
    return OrderSummary(
      subtotal: json['subtotal'] ?? 0,
      deliveryFee: json['deliveryFee'] ?? 0,
      discount: json['discount'] ?? 0,
      totalPrice: json['totalPrice'] ?? 0,
      paymentMethod: json['paymentMethod'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subtotal': subtotal,
      'deliveryFee': deliveryFee,
      'discount': discount,
      'totalPrice': totalPrice,
      'paymentMethod': paymentMethod,
    };
  }
}
