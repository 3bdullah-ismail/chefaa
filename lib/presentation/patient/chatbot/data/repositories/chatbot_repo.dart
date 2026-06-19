import '../models/chat_message_model.dart';
import '../models/chatbot_response.dart';

abstract class ChatbotRepo {
  Future<ChatbotResponse> sendMessage({
    required String message,
    required List<ChatMessageModel> conversationHistory,
  });
}
