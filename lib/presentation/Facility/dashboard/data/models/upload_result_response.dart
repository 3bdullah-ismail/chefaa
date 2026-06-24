class UploadResultResponse {
  final bool? success;
  final String? message;
  final UpdatedRequest? updatedRequest;

  UploadResultResponse({this.success, this.message, this.updatedRequest});

  factory UploadResultResponse.fromJson(Map<String, dynamic> json) {
    return UploadResultResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      updatedRequest: json['updatedRequest'] != null
          ? UpdatedRequest.fromJson(json['updatedRequest'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (success != null) 'success': success,
      if (message != null) 'message': message,
      if (updatedRequest != null) 'updatedRequest': updatedRequest!.toJson(),
    };
  }
}

class UpdatedRequest {
  final String? id;
  final String? labId;
  final String? patientId;
  final List<String>? services;
  final bool? viaAI;
  final String? resultFile;
  final String? resultFileType;
  final String? resultUploadedAt;
  final String? status;

  UpdatedRequest({
    this.id,
    this.labId,
    this.patientId,
    this.services,
    this.viaAI,
    this.resultFile,
    this.resultFileType,
    this.resultUploadedAt,
    this.status,
  });

  factory UpdatedRequest.fromJson(Map<String, dynamic> json) {
    return UpdatedRequest(
      id: json['_id'] as String? ?? json['id'] as String?,
      labId: json['labId'] as String?,
      patientId: json['patientId'] as String?,
      services: (json['services'] as List?)?.map((e) => e as String).toList(),
      viaAI: json['viaAI'] as bool?,
      resultFile: json['resultFile'] as String?,
      resultFileType: json['resultFileType'] as String?,
      resultUploadedAt: json['resultUploadedAt'] as String?,
      status: json['status'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) '_id': id,
      if (labId != null) 'labId': labId,
      if (patientId != null) 'patientId': patientId,
      if (services != null) 'services': services,
      if (viaAI != null) 'viaAI': viaAI,
      if (resultFile != null) 'resultFile': resultFile,
      if (resultFileType != null) 'resultFileType': resultFileType,
      if (resultUploadedAt != null) 'resultUploadedAt': resultUploadedAt,
      if (status != null) 'status': status,
    };
  }
}
