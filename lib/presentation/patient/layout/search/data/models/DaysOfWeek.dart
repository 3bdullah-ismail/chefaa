class DaysOfWeek {
  DaysOfWeek({
      this.day, 
      this.open, 
      this.close, 
      this.id, 
      this.breaks,});

  DaysOfWeek.fromJson(dynamic json) {
    day = json['day'];
    open = json['open'];
    close = json['close'];
    id = json['_id'];
    if (json['breaks'] != null) {
      breaks = [];
      json['breaks'].forEach((v) {
        breaks?.add(Dynamic.fromJson(v));
      });
    }
  }
  String? day;
  String? open;
  String? close;
  String? id;
  List<dynamic>? breaks;

  get Dynamic => null;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['day'] = day;
    map['open'] = open;
    map['close'] = close;
    map['_id'] = id;
    if (breaks != null) {
      map['breaks'] = breaks?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}