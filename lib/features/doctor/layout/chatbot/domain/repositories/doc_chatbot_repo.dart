import 'package:chefaa/features/doctor/layout/chatbot/data/models/chatbot_doc.dart';

import 'package:chefaa/features/doctor/layout/chatbot/data/models/chat_history.dart';

abstract class DocChatbotRepo{
  Future<ChatbotDoc> getResponse({
    required String message,
    required List<ChatHistory> history,
  });
}
