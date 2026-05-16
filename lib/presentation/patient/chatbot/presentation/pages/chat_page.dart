import 'package:chefaa/core/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../widgets/bot_message.dart';
import '../widgets/chat_header.dart';
import '../widgets/chat_input_bar.dart';
import '../widgets/user_message.dart';

class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({required this.text, required this.isUser});
}

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<ChatMessage> _messages = [
    ChatMessage(
      text:
          'Welcome! How can I help you today with your medications or health condition?',
      isUser: false,
    ),
    ChatMessage(
      text:
          'I am looking for an available alternative for my blood pressure medication.',
      isUser: true,
    ),
  ];
  final TextEditingController _chatController = TextEditingController();

  void _sendMessage() {
    final String text = _chatController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _messages.add(ChatMessage(text: text, isUser: true));
      });
      _chatController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.lightGray,
      appBar: AppBar(
        backgroundColor: ColorManager.lightGray,
        elevation: 0,
        scrolledUnderElevation: 1,
        shadowColor: ColorManager.black.withValues(alpha: 0.1),
        leading: IconButton(
          icon: const Icon(Symbols.arrow_back, color: ColorManager.black),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const ChatHeader(),
        actions: [
          IconButton(
            icon: const Icon(Symbols.more_vert, color: ColorManager.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                if (message.isUser) {
                  return UserMessage(message: message.text);
                } else {
                  return BotMessage(message: message.text);
                }
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
              onSend: _sendMessage,
            ),
          ),
        ],
      ),
    );
  }
}
