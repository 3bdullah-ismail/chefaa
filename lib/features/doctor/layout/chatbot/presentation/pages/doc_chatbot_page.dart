import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chefaa/features/doctor/layout/chatbot/presentation/manager/doc_chatbot_cubit.dart';
import 'package:chefaa/features/doctor/layout/chatbot/presentation/widgets/chatbot_appbar.dart';
import 'package:chefaa/features/doctor/layout/chatbot/presentation/widgets/doc_chat_input_bar.dart';
import 'package:chefaa/features/doctor/layout/chatbot/presentation/widgets/message_bubble.dart';
import 'package:chefaa/features/doctor/layout/chatbot/presentation/widgets/typing_bubble.dart';

class DocChatbotPage extends StatefulWidget {
  const DocChatbotPage({super.key});

  @override
  State<DocChatbotPage> createState() => _DocChatbotPageState();
}

class _DocChatbotPageState extends State<DocChatbotPage> {
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void sendMessage() {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    context.read<DocChatbotCubit>().sendMessage(text);
    messageController.clear();
    scrollToBottom();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final messages = context.select((DocChatbotCubit c) => c.messages);

    return Scaffold(
      appBar: const ChatAppBar(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              controller: scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final item = messages[index];

                if (item["isLoading"] == true) {
                  return const TypingBubble();
                }

                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) => SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, -0.2),
                      end: Offset.zero,
                    ).animate(animation),
                    child: FadeTransition(opacity: animation, child: child),
                  ),
                  child: ChatMessageBubble(
                    key: ValueKey(index),
                    message: item["message"] ?? '',
                    isBot: item["isBot"] ?? false,
                  ),
                );
              },
            ),
          ),
          DocChatInputBar(
            controller: messageController,
            onSend: sendMessage,
          ),
        ],
      ),
    );
  }
}
