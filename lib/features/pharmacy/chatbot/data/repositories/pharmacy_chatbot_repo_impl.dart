import 'dart:convert';
import 'dart:isolate';
import 'package:chefaa/core/error_handling/failure.dart';
import 'package:chefaa/features/pharmacy/chatbot/data/data_sources/pharmacy_chatbot_data_source.dart';
import 'package:chefaa/features/pharmacy/chatbot/data/models/chat_context_response.dart';
import 'package:chefaa/features/pharmacy/chatbot/data/models/chat_response.dart';
import 'package:chefaa/features/pharmacy/chatbot/domain/repositories/pharmacy_chatbot_repo.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: PharmacyChatbotRepo)
class PharmacyChatbotRepoImpl implements PharmacyChatbotRepo {
  final PharmacyChatbotDataSource pharmacyChatbotDataSource;

  PharmacyChatbotRepoImpl({required this.pharmacyChatbotDataSource});

  @override
  Future<ChatContextResponse> getChatContext() async {
    try {
      final response = await pharmacyChatbotDataSource.getChatContext();
      final responseBody = response.data;
      ChatContextResponse data;
      if (responseBody is String) {
        final decoded = await Isolate.run(() => jsonDecode(responseBody));
        data = ChatContextResponse.fromJson(
          decoded as Map<String, dynamic>,
        );
      } else {
        data = ChatContextResponse.fromJson(
          responseBody as Map<String, dynamic>,
        );
      }
      return data;
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e).message;
    } catch (e) {
      throw ServerFailure.unexpectedError;
    }
  }

  @override
  Future<ChatResponse> sendChatMessage({
    required String question,
    required Map<String, dynamic> context,
  }) async {
    try {
      final response = await pharmacyChatbotDataSource.sendChatMessage(
        question: question,
        context: context,
      );
      final responseBody = response.data;
      ChatResponse data;
      if (responseBody is String) {
        final decoded = await Isolate.run(() => jsonDecode(responseBody));
        data = ChatResponse.fromJson(
          decoded as Map<String, dynamic>,
        );
      } else {
        data = ChatResponse.fromJson(
          responseBody as Map<String, dynamic>,
        );
      }
      return data;
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e).message;
    } catch (e) {
      throw ServerFailure.unexpectedError;
    }
  }
}
