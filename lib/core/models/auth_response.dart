class AuthResponse {
  AuthResponse({
    String? message,
    String? accessToken,
    String? refreshToken,
    User? user,
  }) {
    _message = message;
    _accessToken = accessToken;
    _refreshToken = refreshToken;
    _user = user;
  }

  AuthResponse.fromJson(dynamic json) {
    _message = json['message'];
    _accessToken = json['accessToken'];
    _refreshToken = json['refreshToken'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  String? _message;
  String? _accessToken;
  String? _refreshToken;
  User? _user;
  AuthResponse copyWith({
    String? message,
    String? accessToken,
    String? refreshToken,
    User? user,
  }) => AuthResponse(
    message: message ?? _message,
    accessToken: accessToken ?? _accessToken,
    refreshToken: refreshToken ?? _refreshToken,
    user: user ?? _user,
  );
  String? get message => _message;
  String? get accessToken => _accessToken;
  String? get refreshToken => _refreshToken;
  User? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['accessToken'] = _accessToken;
    map['refreshToken'] = _refreshToken;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }
}

class User {
  User({String? id, String? name, String? role}) {
    _id = id;
    _name = name;
    _role = role;
  }

  User.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _role = json['role'];
  }
  String? _id;
  String? _name;
  String? _role;
  User copyWith({String? id, String? name, String? role}) =>
      User(id: id ?? _id, name: name ?? _name, role: role ?? _role);
  String? get id => _id;
  String? get name => _name;
  String? get role => _role;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['role'] = _role;
    return map;
  }
}
