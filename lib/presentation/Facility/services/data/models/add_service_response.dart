import 'package:chefaa/presentation/facility/services/data/models/service_model.dart';

class AddServiceResponse {
  final String? message;
  final ServiceModel? service;

  AddServiceResponse({this.message, this.service});

  factory AddServiceResponse.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      return AddServiceResponse(
        message: json['message'] as String?,
        service: json['newService'] != null
            ? ServiceModel.fromJson(json['newService'] as Map<String, dynamic>)
            : (json['service'] != null
                  ? ServiceModel.fromJson(
                      json['service'] as Map<String, dynamic>,
                    )
                  : (json['data'] != null && json['data']['service'] != null
                        ? ServiceModel.fromJson(
                            json['data']['service'] as Map<String, dynamic>,
                          )
                        : (json['_id'] != null || json['id'] != null
                              ? ServiceModel.fromJson(json)
                              : null))),
      );
    }
    return AddServiceResponse();
  }

  Map<String, dynamic> toJson() {
    return {
      if (message != null) 'message': message,
      if (service != null) 'service': service!.toJson(),
    };
  }
}

