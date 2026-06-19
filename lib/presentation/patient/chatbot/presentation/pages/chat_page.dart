import 'package:chefaa/core/config/get_config.dart';
import 'package:chefaa/core/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../manager/chatbot_cubit.dart';
import '../manager/chatbot_state.dart';
import '../widgets/chat_header.dart';
import '../widgets/chat_input_bar.dart';
import '../widgets/chat_message.dart';
import '../widgets/chatbot_landing_widget.dart';
import '../widgets/typing_indicator.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _chatController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _chatController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  void _sendMessage(BuildContext context, {String? customText}) {
    final String text = (customText ?? _chatController.text).trim();
    if (text.isNotEmpty) {
      context.read<ChatbotCubit>().sendMessage(text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ChatbotCubit>(),
      child: Scaffold(
        backgroundColor: ColorManager.lightGray,
        appBar: AppBar(
          backgroundColor: ColorManager.lightGray,
          elevation: 0,
          scrolledUnderElevation: 1,
          shadowColor: ColorManager.black.withValues(alpha: 0.1),
          automaticallyImplyLeading: false,
          title: const ChatHeader(),
          actions: [
            IconButton(
              icon: const Icon(Symbols.more_vert, color: ColorManager.black),
              onPressed: () {},
            ),
          ],
        ),
        body: BlocConsumer<ChatbotCubit, ChatbotState>(
          listener: (context, state) {
            if (state is ChatbotSuccess) {
              _chatController.clear();
              _scrollToBottom();
            } else if (state is ChatbotLoading) {
              _scrollToBottom();
            } else if (state is ChatbotError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            final history = state.conversationHistory;
            final isChatLoading = state is ChatbotLoading;
            final hasUserMessages = history.any((m) => m.role == 'user');

            final totalItems =
                history.length +
                (isChatLoading ? 1 : 0) +
                (!hasUserMessages ? 1 : 0);

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 24,
                    ),
                    itemCount: totalItems,
                    itemBuilder: (context, index) {
                      int adjustedIndex = index;
                      if (!hasUserMessages) {
                        if (index == 0) {
                          return ChatbotLandingWidget(
                            onActionTap: (text) =>
                                _sendMessage(context, customText: text),
                          );
                        }
                        adjustedIndex = index - 1;
                      }

                      if (adjustedIndex == history.length) {
                        return const TypingIndicator();
                      }

                      final message = history[adjustedIndex];
                      return ChatMessage(
                        message: message.content,
                        isUser: message.role == 'user',
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: ColorManager.white,
                    boxShadow: [
                      BoxShadow(
                        color: ColorManager.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, -1),
                      ),
                    ],
                  ),
                  child: ChatInputBar(
                    controller: _chatController,
                    onSend: () => _sendMessage(context),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
