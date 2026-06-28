class GetDashboardResponse {
  final bool? success;
  final num? pendingCount;
  final num? uploadedCount;
  final List<DashboardRequestItem>? pendingUploads;
  final List<DashboardRequestItem>? uploadedResults;

  GetDashboardResponse({
    this.success,
    this.pendingCount,
    this.uploadedCount,
    this.pendingUploads,
    this.uploadedResults,
  });

  factory GetDashboardResponse.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('stats') || json.containsKey('todaysRequests')) {
      final statsObj = json['stats'] as Map<String, dynamic>?;
      final todaysRequestsList = json['todaysRequests'] as List<dynamic>? ?? [];
      final resultsUploadedTodayList =
          json['resultsUploadedToday'] as List<dynamic>? ?? [];

      // Map pending requests (where status != completed)
      final pendingList = todaysRequestsList
          .map((e) => DashboardRequestItem.fromJson(e as Map<String, dynamic>))
          .where((item) => item.status != 'completed')
          .toList();

      // Map uploaded results
      final uploadedList = resultsUploadedTodayList
          .map((e) => DashboardRequestItem.fromJson(e as Map<String, dynamic>))
          .toList();

      return GetDashboardResponse(
        success: json['success'] as bool?,
        pendingCount: statsObj?['todaysRequests'] as num?,
        uploadedCount: statsObj?['completedToday'] as num?,
        pendingUploads: pendingList,
        uploadedResults: uploadedList,
      );
    }

    return GetDashboardResponse(
      success: json['success'] as bool?,
      pendingCount: json['pendingCount'] as num?,
      uploadedCount: json['uploadedCount'] as num?,
      pendingUploads: (json['pendingUploads'] as List<dynamic>?)
          ?.map((e) => DashboardRequestItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      uploadedResults: (json['uploadedResults'] as List<dynamic>?)
          ?.map((e) => DashboardRequestItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (success != null) 'success': success,
      if (pendingCount != null) 'pendingCount': pendingCount,
      if (uploadedCount != null) 'uploadedCount': uploadedCount,
      if (pendingUploads != null)
        'pendingUploads': pendingUploads!.map((e) => e.toJson()).toList(),
      if (uploadedResults != null)
        'uploadedResults': uploadedResults!.map((e) => e.toJson()).toList(),
    };
  }
}

class DashboardRequestItem {
  final String? id;
  final String? patientName;
  final List<String>? services;
  final String? status;
  final String? createdAt;

  DashboardRequestItem({
    this.id,
    this.patientName,
    this.services,
    this.status,
    this.createdAt,
  });

  factory DashboardRequestItem.fromJson(Map<String, dynamic> json) {
    String? pName;
    final patientObj = json['patientId'];
    if (patientObj is Map<String, dynamic>) {
      pName = patientObj['name'] as String?;
    } else if (json['patientName'] is String) {
      pName = json['patientName'] as String?;
    } else if (patientObj is String) {
      pName = patientObj;
    }

    final serviceVal = json['services'];
    List<String>? servicesList;
    if (serviceVal is List) {
      servicesList = serviceVal.map((e) => e.toString()).toList();
    } else if (json['analysisName'] is String) {
      servicesList = [json['analysisName'] as String];
    }

    return DashboardRequestItem(
      id:
          json['_id'] as String? ??
          json['id'] as String? ??
          json['ref'] as String?,
      patientName: pName,
      services: servicesList,
      status: json['status'] as String?,
      createdAt:
          json['createdAt'] as String? ??
          json['bookedAt'] as String? ??
          json['resultUploadedAt'] as String? ??
          json['uploadedAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) '_id': id,
      if (patientName != null) 'patientName': patientName,
      if (services != null) 'services': services,
      if (status != null) 'status': status,
      if (createdAt != null) 'createdAt': createdAt,
    };
  }
}
