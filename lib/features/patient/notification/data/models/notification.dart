class Notification {
  Notification({
      this.id, 
      this.recipient, 
      this.title, 
      this.message, 
      this.type, 
      this.isRead, 
      this.createdAt, 
      this.v,});

  Notification.fromJson(dynamic json) {
    if (json is! Map<String, dynamic>) throw const FormatException('Invalid JSON');
    id = json['_id'];
    recipient = json['recipient'];
    title = json['title'];
    message = json['message'];
    type = json['type'];
    isRead = json['isRead'];
    createdAt = json['createdAt'];
    v = json['__v'];
  }
  String? id;
  String? recipient;
  String? title;
  String? message;
  String? type;
  bool? isRead;
  String? createdAt;
  num? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['recipient'] = recipient;
    map['title'] = title;
    map['message'] = message;
    map['type'] = type;
    map['isRead'] = isRead;
    map['createdAt'] = createdAt;
    map['__v'] = v;
    return map;
  }

}