import 'package:chefaa/features/patient/chatbot/data/models/chat_message_model.dart';

sealed class ChatbotState {
  final List<ChatMessageModel> conversationHistory;

  ChatbotState(this.conversationHistory);
}

final class ChatbotInitial extends ChatbotState {
  ChatbotInitial(super.conversationHistory);
}

final class ChatbotLoading extends ChatbotState {
  ChatbotLoading(super.conversationHistory);
}

final class ChatbotSuccess extends ChatbotState {
  ChatbotSuccess(super.conversationHistory);
}

final class ChatbotError extends ChatbotState {
  final String error;

  ChatbotError(super.conversationHistory, this.error);
}
