import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laxmii_app/core/extensions/overlay_extension.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/features/ai_chat/data/model/chat_ai_request.dart';
import 'package:laxmii_app/presentation/features/ai_chat/data/model/get_chat_history_request.dart';
import 'package:laxmii_app/presentation/features/ai_chat/data/model/get_chat_history_response.dart';
import 'package:laxmii_app/presentation/features/ai_chat/presentation/notifier/chat_ai_notifier.dart';
import 'package:laxmii_app/presentation/features/ai_chat/presentation/notifier/get_chat_history_notifier.dart';
import 'package:laxmii_app/presentation/features/ai_chat/presentation/notifier/start_new_chat_notifier.dart';
import 'package:laxmii_app/presentation/features/ai_chat/presentation/widget/ai_message_card.dart';
import 'package:laxmii_app/presentation/features/ai_chat/presentation/widget/user_chat_card.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/get_access_token_notifier.dart';
import 'package:laxmii_app/presentation/general_widgets/laxmii_app_bar.dart';

class ChatView extends ConsumerStatefulWidget {
  const ChatView({super.key});
  static const String routeName = '/chatView';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatViewState();
}

class _ChatViewState extends ConsumerState<ChatView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(startChatNotifier.notifier).startNewChat(
        onError: (error) {
          context.showError(message: error);
        },
      );

      getChatHistory();

      await ref.read(getAccessTokenNotifier.notifier).accessToken();
    });
    super.initState();
  }

  void getChatHistory() async {
    final sessionId = ref.watch(startChatNotifier
        .select((v) => v.startNewChatResponse.data?.sessionId));
    final data = GetChatHistoryRequest(sessionId: '$sessionId');

    await ref.read(getChatHistoryNotifier.notifier).getChatHistory(
          onError: (error) {
            context.showError(message: error);
          },
          data: data,
        );
  }

  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  final _controller = TextEditingController();

  void _sendMessage(
      {required String sessionId,
      required String userInput,
      required List<AiChatMessages> messages}) {
    final data = ChatAiRequest(sessionId: sessionId, userInput: userInput);
    if (userInput.trim().isEmpty) return;

    ref.read(chatAiNotifier.notifier).chatAi(
        data: data,
        onError: (error) {
          context.showError(message: error);
        },
        onSuccess: () {
          getChatHistory();
        });

    _controller.clear();

    setState(() {
      messages.add(AiChatMessages(message: userInput, id: 'user'));
      // messages.add(ChatModel(message: "", type: false, isLoading: true));
    });

    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    final sessionId = ref.watch(startChatNotifier
        .select((v) => v.startNewChatResponse.data?.sessionId));

    final messageHistory = ref.watch(getChatHistoryNotifier
        .select((v) => v.getChatHistoryResponse.data?.messages ?? []));
    return Scaffold(
      appBar: const LaxmiiAppBar(
        title: 'AI Assistant',
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: messageHistory.isEmpty
                  ? const Center(
                      child: Text(
                        'No chat yet',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      itemCount: messageHistory.length,
                      itemBuilder: (_, index) {
                        final message = messageHistory[index];
                        if (message.sender == 'user') {
                          return UserChatCard(
                            message: message.message ?? '',
                            type: message.sender.toString(),
                          );
                        } else {
                          return AiMessageCard(
                            type: message.sender.toString(),
                            message: message.message ?? '',
                          );
                        }
                      },
                    ),
            ),
            const Divider(
              color: AppColors.primary101010,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.08,
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary101010,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        style: context.textTheme.s12w400.copyWith(
                          color: AppColors.primaryC4C4C4,
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        minLines: 1,
                        onChanged: (value) {},
                        decoration: const InputDecoration(
                            filled: false,
                            hintText: 'Write your question',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none),
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          // final userMessage = AiChatMessages(
                          //   sender: 'user',
                          //   message: _controller.text.trim(),
                          // );
                          // setState(() {
                          //   messageHistory.add(userMessage);
                          // });
                          _sendMessage(
                              sessionId: '$sessionId',
                              userInput: _controller.text.trim(),
                              messages: messageHistory);

                          getChatHistory();
                        },
                        child: SvgPicture.asset('assets/icons/send.svg'))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
    // Scaffold(
    //   appBar: const LaxmiiAppBar(
    //     title: 'AI Assistant',
    //     centerTitle: true,
    //   ),
    //   body: SafeArea(
    //     child: SingleChildScrollView(
    //       child: Column(
    //         children: [
    //           const Divider(
    //             color: AppColors.primary101010,
    //           ),
    //           const VerticalSpacing(25),
    //           messageHistory.isEmpty
    //               ? const Text(
    //                   'No chat yet',
    //                   style: TextStyle(color: Colors.white),
    //                 )
    //               : SizedBox(
    //                   height: MediaQuery.of(context).size.height,
    //                   child: ListView.builder(
    //                     itemCount: messageHistory.length,
    //                     itemBuilder: (_, index) {
    //                       final message = messageHistory[index];
    //                       if (message.sender == 'user') {
    //                         return UserChatCard(
    //                           message: message.message ?? '',
    //                           type: message.sender.toString(),
    //                         );
    //                       } else {
    //                         return AiMessageCard(
    //                           type: message.sender.toString(),
    //                           message: message.message ?? '',
    //                         );
    //                       }
    //                     },
    //                   ),
    //                 ),
    //           Padding(
    //             padding:
    //                 const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
    //             child: Container(
    //               height: MediaQuery.of(context).size.height * 0.08,
    //               padding: const EdgeInsets.symmetric(
    //                 horizontal: 15,
    //               ),
    //               decoration: BoxDecoration(
    //                 color: AppColors.primary101010,
    //                 borderRadius: BorderRadius.circular(30),
    //               ),
    //               child: Row(
    //                 children: [
    //                   Expanded(
    //                     child: TextField(
    //                       controller: _controller,
    //                       style: context.textTheme.s12w400.copyWith(
    //                         color: AppColors.primaryC4C4C4,
    //                       ),
    //                       keyboardType: TextInputType.multiline,
    //                       maxLines: 5,
    //                       minLines: 1,
    //                       onChanged: (value) {},
    //                       decoration: const InputDecoration(
    //                           filled: false,
    //                           hintText: 'Write your question',
    //                           hintStyle: TextStyle(
    //                             color: Colors.grey,
    //                           ),
    //                           border: InputBorder.none,
    //                           focusedBorder: InputBorder.none),
    //                     ),
    //                   ),
    //                   GestureDetector(
    //                       onTap: () {
    //                         _sendMessage(
    //                             sessionId: sessionId ?? '',
    //                             userInput: _controller.text.trim(),
    //                             messages: messageHistory);

    //                         getChatHistory();
    //                       },
    //                       child: SvgPicture.asset('assets/icons/send.svg'))
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );

