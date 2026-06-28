import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:chefaa/core/services/network_service.dart';
import 'package:chefaa/features/patient/chatbot/data/models/chat_message_model.dart';
import 'chatbot_remote_data_source.dart';

@Injectable(as: ChatbotRemoteDataSource)
class ChatbotRemoteDataSourceImp implements ChatbotRemoteDataSource {
  final NetworkService networkService;

  ChatbotRemoteDataSourceImp(this.networkService);

  @override
  Future<Response<dynamic>> sendMessage({
    required String message,
    required List<ChatMessageModel> conversationHistory,
  }) async {
    final response = await networkService.dio.post(
      "/chatboot/chat",
      data: {
        "message": message,
        "conversationHistory": conversationHistory
            .map((e) => e.toJson())
            .toList(),
      },
    );
    return response;
  }
}
