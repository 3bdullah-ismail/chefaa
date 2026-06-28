import 'package:dio/dio.dart';

abstract class PharmacyChatbotDataSource {
  Future<Response> getChatContext();
  Future<Response> sendChatMessage({
    required String question,
    required Map<String, dynamic> context,
  });
}
