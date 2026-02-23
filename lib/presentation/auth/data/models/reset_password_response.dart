class ResetPasswordResponse {
  ResetPasswordResponse({String? message}) {
    _message = message;
  }

  ResetPasswordResponse.fromJson(dynamic json) {
    _message = json['message'];
  }
  String? _message;
  ResetPasswordResponse copyWith({String? message}) =>
      ResetPasswordResponse(message: message ?? _message);
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    return map;
  }
}
