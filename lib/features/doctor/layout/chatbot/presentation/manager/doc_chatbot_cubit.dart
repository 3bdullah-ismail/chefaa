import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:chefaa/features/doctor/layout/chatbot/data/models/chat_history.dart';
import 'package:chefaa/features/doctor/layout/chatbot/domain/repositories/doc_chatbot_repo.dart';
import 'doc_chatbot_state.dart';

@injectable
class DocChatbotCubit extends Cubit<DocChatbotState> {
  final DocChatbotRepo docChatbotRepo;

  final List<Map<String, dynamic>> _messages = [
    {"message": "Hello 👋\nHow can I help you today?", "isBot": true},
  ];

  List<Map<String, dynamic>> get messages => _messages;

  DocChatbotCubit({required this.docChatbotRepo})
      : super(DocChatbotInitialState());

  static DocChatbotCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    _messages.add({"message": text, "isBot": false});
    _messages.add({"isBot": true, "isLoading": true});
      if (!isClosed) emit(DocChatbotLoadingState(List.of(_messages)));

    final history = _messages
        .where((m) => m["isLoading"] != true)
        .take(_messages.length - 2)
        .map((m) => ChatHistory(
      role: m["isBot"] == true ? "assistant" : "user",
      content: m["message"] ?? '',
    ))
        .toList();

    try {
      final response = await docChatbotRepo.getResponse(
        message: text,
        history: history,
      );

      _messages.removeWhere((e) => e["isLoading"] == true);
      _messages.add({"message": response.reply ?? '', "isBot": true});
      if (!isClosed) emit(DocChatbotSuccessState(List.of(_messages)));
    } catch (e) {
      _messages.removeWhere((e) => e["isLoading"] == true);
      _messages.add({"message": e.toString(), "isBot": true});
      if (!isClosed) emit(DocChatbotErrorState(List.of(_messages), e.toString()));
    }
  }
}