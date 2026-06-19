import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/chat_message_model.dart';
import '../../data/repositories/chatbot_repo.dart';
import 'chatbot_state.dart';

@injectable
class ChatbotCubit extends Cubit<ChatbotState> {
  final ChatbotRepo chatbotRepo;

  ChatbotCubit(this.chatbotRepo)
      : super(
          ChatbotInitial([
            ChatMessageModel(
              role: 'assistant',
              content:
                  'Welcome! How can I help you today with your medications or health condition?',
            ),
          ]),
        );

  static ChatbotCubit get(BuildContext context) => BlocProvider.of<ChatbotCubit>(context);

  Future<void> sendMessage(String text) async {
    final trimmedText = text.trim();
    if (trimmedText.isEmpty) return;

    final previousHistory = state.conversationHistory;
    final updatedHistory = List<ChatMessageModel>.from(previousHistory)
      ..add(ChatMessageModel(role: 'user', content: trimmedText));

    emit(ChatbotLoading(updatedHistory));

    try {
      final response = await chatbotRepo.sendMessage(
        message: trimmedText,
        conversationHistory: previousHistory,
      );

      final newHistory = response.data?.conversationHistory ?? updatedHistory;
      emit(ChatbotSuccess(newHistory));
    } catch (e) {
      emit(ChatbotError(previousHistory, e.toString()));
    }
  }
}
