import 'package:chefaa/features/pharmacy/chatbot/data/models/chat_context_response.dart';
import 'package:chefaa/features/pharmacy/chatbot/data/models/chat_response.dart';

abstract class PharmacyChatbotRepo {
  Future<ChatContextResponse> getChatContext();
  Future<ChatResponse> sendChatMessage({
    required String question,
    required Map<String, dynamic> context,
  });
}
