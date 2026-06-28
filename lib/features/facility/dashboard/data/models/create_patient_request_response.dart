class CreatePatientRequestResponse {
  final bool? success;
  final String? message;
  final NewRequestData? newRequest;

  CreatePatientRequestResponse({this.success, this.message, this.newRequest});

  factory CreatePatientRequestResponse.fromJson(Map<String, dynamic> json) {
    return CreatePatientRequestResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      newRequest: json['newRequest'] != null
          ? NewRequestData.fromJson(json['newRequest'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (success != null) 'success': success,
      if (message != null) 'message': message,
      if (newRequest != null) 'newRequest': newRequest!.toJson(),
    };
  }
}

class NewRequestData {
  final String? id;
  final String? labId;
  final String? patientId;
  final List<String>? services;
  final bool? viaAI;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

  NewRequestData({
    this.id,
    this.labId,
    this.patientId,
    this.services,
    this.viaAI,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory NewRequestData.fromJson(Map<String, dynamic> json) {
    return NewRequestData(
      id: json['_id'] as String? ?? json['id'] as String?,
      labId: json['labId'] as String?,
      patientId: json['patientId'] as String?,
      services: (json['services'] as List?)?.map((e) => e as String).toList(),
      viaAI: json['viaAI'] as bool?,
      status: json['status'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) '_id': id,
      if (labId != null) 'labId': labId,
      if (patientId != null) 'patientId': patientId,
      if (services != null) 'services': services,
      if (viaAI != null) 'viaAI': viaAI,
      if (status != null) 'status': status,
      if (createdAt != null) 'createdAt': createdAt,
      if (updatedAt != null) 'updatedAt': updatedAt,
    };
  }
}
