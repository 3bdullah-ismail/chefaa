class Brief {
  Brief({
      this.generatedAt, 
      this.lang, 
      this.brief,});

  Brief.fromJson(dynamic json) {
    generatedAt = json['generatedAt'];
    lang = json['lang'];
    brief = json['brief'];
  }
  String? generatedAt;
  String? lang;
  String? brief;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['generatedAt'] = generatedAt;
    map['lang'] = lang;
    map['brief'] = brief;
    return map;
  }

}