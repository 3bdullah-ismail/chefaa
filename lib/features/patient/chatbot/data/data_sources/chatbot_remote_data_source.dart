import 'package:dio/dio.dart';

import 'package:chefaa/features/patient/chatbot/data/models/chat_message_model.dart';

abstract class ChatbotRemoteDataSource {
  Future<Response> sendMessage({
    required String message,
    required List<ChatMessageModel> conversationHistory,
  });
}
