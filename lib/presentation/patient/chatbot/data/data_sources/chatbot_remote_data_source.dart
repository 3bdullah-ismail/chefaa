import 'package:dio/dio.dart';

import '../models/chat_message_model.dart';

abstract class ChatbotRemoteDataSource {
  Future<Response> sendMessage({
    required String message,
    required List<ChatMessageModel> conversationHistory,
  });
}
