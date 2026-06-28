import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:chefaa/core/config/get_config.dart';
import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/constants_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/features/pharmacy/chatbot/presentation/manager/pharmacy_chatbot_cubit.dart';
import 'package:chefaa/features/pharmacy/chatbot/presentation/widgets/chatbot_appbar.dart';
import 'package:chefaa/features/pharmacy/chatbot/presentation/widgets/message_bubble.dart';
import 'package:chefaa/features/pharmacy/chatbot/presentation/widgets/pharmacy_chat_input_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PharmacyChatbotPage extends StatefulWidget {
  const PharmacyChatbotPage({super.key});

  @override
  State<PharmacyChatbotPage> createState() => _PharmacyChatbotPageState();
}

class _PharmacyChatbotPageState extends State<PharmacyChatbotPage> {
  final TextEditingController messageController = TextEditingController();
  bool _hasInitializedWelcomeMessage = false;

  void onSendPressed(BuildContext context) {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    context.read<PharmacyChatbotCubit>().sendMessage(text);
    messageController.clear();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PharmacyChatbotCubit>(
      create: (context) => getIt<PharmacyChatbotCubit>()..getChatContext(),
      child: Scaffold(
        backgroundColor: const Color(0xffF5F7FB),
        appBar: const ChatAppBar(),
        body: BlocConsumer<PharmacyChatbotCubit, PharmacyChatbotState>(
          listener: (context, state) {
            final cubit = context.read<PharmacyChatbotCubit>();
            if (state is ChatbotError && cubit.latestContext != null) {
              AnimatedSnackBar.rectangle(
                AppConstants.error,
                state.errorMessage,
                type: AnimatedSnackBarType.error,
                brightness: Brightness.dark,
              ).show(context);
            }
          },
          builder: (context, state) {
            final cubit = context.read<PharmacyChatbotCubit>();

            if (state is LoadingContext) {
              return const Center(
                child: CircularProgressIndicator(
                  color: ColorManager.primary,
                ),
              );
            }

            if (state is ChatbotError && cubit.latestContext == null) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        state.errorMessage,
                        textAlign: TextAlign.center,
                        style: getMediumStyle(
                          color: ColorManager.error,
                          fontSize: 16.sp,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          context.read<PharmacyChatbotCubit>().getChatContext();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.primary,
                          foregroundColor: ColorManager.white,
                        ),
                        child: const Text("Retry"),
                      ),
                    ],
                  ),
                ),
              );
            }

            // Customize welcome message dynamically on success
            if (!_hasInitializedWelcomeMessage && cubit.latestContext != null) {
              final pharmacyName =
                  cubit.latestContext!.profile?.pharmacyName ?? "Pharmacy";
              cubit.messages[0]["message"] =
                  "Hello 👋\nHow can I help you today with $pharmacyName's inventory, orders or financials?";
              _hasInitializedWelcomeMessage = true;
            }

            final isInputDisabled = state is SendingMessage;

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: cubit.messages.length + (isInputDisabled ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == cubit.messages.length) {
                        return const ChatMessageBubble(
                          message: "Pharmacy Assistant is typing...",
                          isBot: true,
                        );
                      }
                      return ChatMessageBubble(
                        message: cubit.messages[index]["message"],
                        isBot: cubit.messages[index]["isBot"],
                      );
                    },
                  ),
                ),
                AbsorbPointer(
                  absorbing: isInputDisabled,
                  child: PharmacyChatInputBar(
                    controller: messageController,
                    onSend: () => onSendPressed(context),
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
