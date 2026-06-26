import 'Usage.dart';

class ChatbotDoc {
  ChatbotDoc({
      this.reply, 
      this.usage,});

  ChatbotDoc.fromJson(dynamic json) {
    reply = json['reply'];
    usage = json['usage'] != null ? Usage.fromJson(json['usage']) : null;
  }
  String? reply;
  Usage? usage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['reply'] = reply;
    if (usage != null) {
      map['usage'] = usage?.toJson();
    }
    return map;
  }

}