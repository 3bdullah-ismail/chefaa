import 'dart:convert';
import 'dart:isolate';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/error_handling/failure.dart';
import '../data_sources/chatbot_remote_data_source.dart';
import '../models/chat_message_model.dart';
import '../models/chatbot_response.dart';
import 'chatbot_repo.dart';

@Injectable(as: ChatbotRepo)
class ChatbotRepoImp implements ChatbotRepo {
  final ChatbotRemoteDataSource chatbotRemoteDataSource;

  ChatbotRepoImp(this.chatbotRemoteDataSource);

  @override
  Future<ChatbotResponse> sendMessage({
    required String message,
    required List<ChatMessageModel> conversationHistory,
  }) async {
    try {
      final response = await chatbotRemoteDataSource.sendMessage(
        message: message,
        conversationHistory: conversationHistory,
      );
      final body = response.data;
      if (body is String) {
        final decoded = await Isolate.run(() => jsonDecode(body));
        return ChatbotResponse.fromJson(decoded);
      }
      return ChatbotResponse.fromJson(body);
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e).message;
    } catch (e) {
      throw ServerFailure.unexpectedError;
    }
  }
}
