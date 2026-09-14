import 'package:chefaa/core/imports/imports.dart';

abstract class PharmacyChatbotDataSource {
  Future<Response> getChatContext();
  Future<Response> sendChatMessage({
    required String question,
    required Map<String, dynamic> context,
  });
}
