part of 'pharmacy_chatbot_cubit.dart';

sealed class PharmacyChatbotState {}

final class PharmacyChatbotInitial extends PharmacyChatbotState {}

final class LoadingContext extends PharmacyChatbotState {}

final class ContextLoaded extends PharmacyChatbotState {
  final ChatContextResponse response;

  ContextLoaded(this.response);
}

final class SendingMessage extends PharmacyChatbotState {}

final class MessageSent extends PharmacyChatbotState {
  final ChatResponse response;

  MessageSent(this.response);
}

final class ChatbotError extends PharmacyChatbotState {
  final String errorMessage;

  ChatbotError(this.errorMessage);
}
