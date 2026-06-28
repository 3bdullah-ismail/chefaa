import 'package:chefaa/core/services/network_service.dart';
import 'package:chefaa/features/pharmacy/chatbot/data/data_sources/pharmacy_chatbot_data_source.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: PharmacyChatbotDataSource)
class PharmacyChatbotDataSourceImpl implements PharmacyChatbotDataSource {
  final NetworkService _networkService;

  PharmacyChatbotDataSourceImpl(this._networkService);

  @override
  Future<Response> getChatContext() {
    return _networkService.dio.get("/pharmacy/ai/chat-context");
  }

  @override
  Future<Response> sendChatMessage({
    required String question,
    required Map<String, dynamic> context,
  }) {
    return _networkService.dio.post(
      "/pharmacy/ai/chat",
      data: {
        "question": question,
        "context": context,
      },
    );
  }
}
