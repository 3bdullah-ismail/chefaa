class WorkingHours {
  WorkingHours({
      this.days, 
      this.time, 
      this.id,});

  WorkingHours.fromJson(dynamic json) {
    days = json['days'];
    time = json['time'];
    id = json['_id'];
  }
  String? days;
  String? time;
  String? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['days'] = days;
    map['time'] = time;
    map['_id'] = id;
    return map;
  }

}