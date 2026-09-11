import 'package:chefaa/core/imports/imports.dart';
import 'package:chefaa/features/doctor/chatbot/data/models/chat_history.dart';

abstract class DocChatbotDataSource {
  Future<Response> getResponse({
    required String message,
    required List<ChatHistory> history,
  });
}
