sealed class DocChatbotState {}

class DocChatbotInitialState extends DocChatbotState {}

class DocChatbotLoadingState extends DocChatbotState {
  final List<Map<String, dynamic>> messages;
  DocChatbotLoadingState(this.messages);
}

class DocChatbotSuccessState extends DocChatbotState {
  final List<Map<String, dynamic>> messages;
  DocChatbotSuccessState(this.messages);
}

class DocChatbotErrorState extends DocChatbotState {
  final List<Map<String, dynamic>> messages;
  final String error;
  DocChatbotErrorState(this.messages, this.error);
}