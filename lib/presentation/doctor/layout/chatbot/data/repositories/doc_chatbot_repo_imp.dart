import 'package:chefaa/presentation/doctor/layout/chatbot/data/data_sources/doc_chatbot_data_source.dart';
import 'package:chefaa/presentation/doctor/layout/chatbot/data/models/Chatbot_doc.dart';
import 'package:chefaa/presentation/doctor/layout/chatbot/data/models/chat_history.dart';
import 'package:chefaa/presentation/doctor/layout/chatbot/data/repositories/doc_chatbot_repo.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/error_handling/failure.dart';

@Injectable(as: DocChatbotRepo)
class DocChatbotRepoImp implements DocChatbotRepo {
  DocChatbotDataSource docChatbotDataSource;

  DocChatbotRepoImp({required this.docChatbotDataSource});

  @override
  Future<ChatbotDoc> getResponse({
    required String message,
    required List<ChatHistory> history,
  }) async {
    try {
      final response = await docChatbotDataSource.getResponse(
        message: message,
        history: history,
      );
      if (response.statusCode == 200) {
        return ChatbotDoc.fromJson(response.data);
      } else {
        throw Exception('Failed to get response from server');
      }
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e).message;
    } catch (e) {
      throw ServerFailure.unexpectedError;
    }
  }
}
