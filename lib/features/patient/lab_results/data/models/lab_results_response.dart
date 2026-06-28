class LabResultsResponse {
  final bool? success;
  final num? count;
  final List<LabResultItem>? results;

  LabResultsResponse({this.success, this.count, this.results});

  factory LabResultsResponse.fromJson(Map<String, dynamic> json) {
    return LabResultsResponse(
      success: json['success'] as bool?,
      count: json['count'] as num?,
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => LabResultItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (success != null) 'success': success,
      if (count != null) 'count': count,
      if (results != null) 'results': results!.map((e) => e.toJson()).toList(),
    };
  }
}

class LabResultItem {
  final String? requestId;
  final String? fileName;
  final String? labName;
  final String? uploadedAt;
  final String? fileUrl;
  final String? fileType;
  final String? doctorNotes;

  LabResultItem({
    this.requestId,
    this.fileName,
    this.labName,
    this.uploadedAt,
    this.fileUrl,
    this.fileType,
    this.doctorNotes,
  });

  factory LabResultItem.fromJson(Map<String, dynamic> json) {
    return LabResultItem(
      requestId: json['requestId'] as String?,
      fileName: json['fileName'] as String?,
      labName: json['labName'] as String?,
      uploadedAt: json['uploadedAt'] as String?,
      fileUrl: json['fileUrl'] as String?,
      fileType: json['fileType'] as String?,
      doctorNotes: json['doctorNotes'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (requestId != null) 'requestId': requestId,
      if (fileName != null) 'fileName': fileName,
      if (labName != null) 'labName': labName,
      if (uploadedAt != null) 'uploadedAt': uploadedAt,
      if (fileUrl != null) 'fileUrl': fileUrl,
      if (fileType != null) 'fileType': fileType,
      if (doctorNotes != null) 'doctorNotes': doctorNotes,
    };
  }
}
