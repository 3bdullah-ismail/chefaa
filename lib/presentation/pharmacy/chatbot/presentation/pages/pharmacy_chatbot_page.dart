import 'package:flutter/material.dart';
import '../widgets/chatbot_appbar.dart';
import '../widgets/message_bubble.dart';
import '../widgets/pharmacy_chat_input_bar.dart';

class PharmacyChatbotPage extends StatefulWidget {
  const PharmacyChatbotPage({super.key});

  @override
  State<PharmacyChatbotPage> createState() => _PharmacyChatbotPageState();
}

class _PharmacyChatbotPageState extends State<PharmacyChatbotPage> {
  final TextEditingController messageController = TextEditingController();

  final List<Map<String, dynamic>> messages = [
    {"message": "Hello 👋\nHow can I help you today?", "isBot": true},
    {"message": "Do you have Panadol in stock?", "isBot": false},
    {"message": "Yes, Panadol Extra is available.", "isBot": true},
  ];

  void sendMessage() {
    if (messageController.text.trim().isEmpty) return;

    setState(() {
      messages.add({"message": messageController.text, "isBot": false});
    });

    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),
      appBar: const ChatAppBar(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ChatMessageBubble(
                  message: messages[index]["message"],
                  isBot: messages[index]["isBot"],
                );
              },
            ),
          ),
          PharmacyChatInputBar(
            controller: messageController,
            onSend: sendMessage,
          ),
        ],
      ),
    );
  }
}
