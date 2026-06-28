import 'package:chefaa/features/pharmacy/chatbot/data/models/chat_context_response.dart';
import 'package:chefaa/features/pharmacy/chatbot/data/models/chat_response.dart';
import 'package:chefaa/features/pharmacy/chatbot/domain/repositories/pharmacy_chatbot_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'pharmacy_chatbot_state.dart';

@injectable
class PharmacyChatbotCubit extends Cubit<PharmacyChatbotState> {
  final PharmacyChatbotRepo pharmacyChatbotRepo;

  ChatContextData? latestContext;

  final List<Map<String, dynamic>> messages = [
    {"message": "Hello 👋\nHow can I help you today?", "isBot": true},
  ];

  PharmacyChatbotCubit(this.pharmacyChatbotRepo)
      : super(PharmacyChatbotInitial());

  Future<void> getChatContext() async {
    if (!isClosed) emit(LoadingContext());
    try {
      final response = await pharmacyChatbotRepo.getChatContext();
      latestContext = response.data;
      if (!isClosed) emit(ContextLoaded(response));
    } catch (e) {
      if (!isClosed) emit(ChatbotError(e.toString()));
    }
  }

  Future<void> sendMessage(String text) async {
    final trimmedText = text.trim();
    if (trimmedText.isEmpty) return;

    // Append user message immediately
    messages.add({"message": trimmedText, "isBot": false});
    if (!isClosed) emit(SendingMessage());

    try {
      final response = await pharmacyChatbotRepo.sendChatMessage(
        question: trimmedText,
        context: latestContext?.toJson() ?? {},
      );
      final answer = response.data?.answer ?? "No response from AI.";

      // Append assistant reply
      messages.add({"message": answer, "isBot": true});
      if (!isClosed) emit(MessageSent(response));
    } catch (e) {
      if (!isClosed) emit(ChatbotError(e.toString()));
    }
  }
}
