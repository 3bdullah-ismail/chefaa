import 'chat_message_model.dart';

class ChatbotResponse {
  final bool? success;
  final String? message;
  final String? error;
  final ChatbotData? data;

  ChatbotResponse({
    this.success,
    this.message,
    this.error,
    this.data,
  });

  factory ChatbotResponse.fromJson(Map<String, dynamic> json) {
    return ChatbotResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      error: json['error'] as String?,
      data: json['data'] != null
          ? ChatbotData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'error': error,
      'data': data?.toJson(),
    };
  }
}

class ChatbotData {
  final String? reply;
  final List<ChatMessageModel>? conversationHistory;

  ChatbotData({
    this.reply,
    this.conversationHistory,
  });

  factory ChatbotData.fromJson(Map<String, dynamic> json) {
    return ChatbotData(
      reply: json['reply'] as String?,
      conversationHistory: json['conversationHistory'] != null
          ? (json['conversationHistory'] as List)
              .map((item) => ChatMessageModel.fromJson(item as Map<String, dynamic>))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reply': reply,
      'conversationHistory': conversationHistory?.map((item) => item.toJson()).toList(),
    };
  }
}
