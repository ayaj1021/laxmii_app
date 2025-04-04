import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laxmii_app/core/extensions/overlay_extension.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/utils/enums.dart';
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
  const ChatView({
    super.key,
    required this.sessionId,
  });
  final String sessionId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatViewState();
}

class _ChatViewState extends ConsumerState<ChatView> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeChat();
  }

  Future<void> _initializeChat() async {
    // Initialize chat session without showing loading

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(startChatNotifier.notifier).startNewChat(
        onError: (error) {
          context.showError(message: error);
        },
      );

      // Get chat history
      await _getChatHistory();

      // Get access token
      await ref.read(getAccessTokenNotifier.notifier).accessToken();
    });
  }

  Future<void> _getChatHistory() async {
    final data = GetChatHistoryRequest(sessionId: widget.sessionId);
    await ref.read(getChatHistoryNotifier.notifier).getChatHistory(
          onError: (error) {
            context.showError(message: error);
          },
          data: data,
        );
  }

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

  Future<void> _sendMessage({
    required String sessionId,
    required String userInput,
    required List<AiChatMessages> messages,
  }) async {
    if (userInput.trim().isEmpty) return;

    final data = ChatAiRequest(sessionId: sessionId, userInput: userInput);

    // Optimistically update UI
    setState(() {
      messages.add(AiChatMessages(message: userInput, sender: 'user'));
    });
    _controller.clear();
    _scrollToBottom();

    // Send message
    await ref.read(chatAiNotifier.notifier).chatAi(
          data: data,
          onError: (error) {
            context.showError(message: error);
          },
          onSuccess: () async {
            await _getChatHistory();
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    final sessionId = ref.watch(startChatNotifier
        .select((v) => v.startNewChatResponse.data?.sessionId));

    final messageHistory = ref.watch(getChatHistoryNotifier
        .select((v) => v.getChatHistoryResponse.data?.messages ?? []));

    final isSendingMessage = ref.watch(
      chatAiNotifier.select((v) => v.loadState.isLoading),
    );
    // final isChatLoading =
    //     ref.watch(getChatHistoryNotifier.select((v) => v.loadState.isLoading));
    final colorScheme = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const LaxmiiAppBar(
        title: 'AI Assistant',
        centerTitle: true,
      ),
      body: SafeArea(
        child:

            // isChatLoading
            //     ? const Center(
            //         child: CircularProgressIndicator(
            //           color: AppColors.primaryColor,
            //         ),
            //       )
            //     :

            Column(
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
                      controller: _scrollController,
                      reverse: true,
                      padding: const EdgeInsets.only(
                        top: 10,
                        bottom: 20,
                        left: 10,
                        right: 10,
                      ),
                      itemCount: messageHistory.length,
                      itemBuilder: (_, index) {
                        final message =
                            messageHistory[messageHistory.length - 1 - index];
                        if (message.sender == 'user') {
                          return UserChatCard(
                            message: message.message ?? '',
                            type: message.sender.toString(),
                          );
                        } else if ((message.sender ?? '').contains('ai')) {
                          return AiMessageCard(
                            type: message.sender.toString(),
                            message: message.message ?? '',
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
            ),
            Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                left: 15,
                right: 15,
                top: 16,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Container(
                constraints: const BoxConstraints(maxHeight: 120),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: colorScheme.cardColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        style: context.textTheme.s12w400.copyWith(
                          color: colorScheme.colorScheme.onSurface,
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        minLines: 1,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: const InputDecoration(
                          filled: false,
                          hintText: 'Write your question',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: GestureDetector(
                        onTap: sessionId != null &&
                                _controller.text.trim().isNotEmpty
                            ? () => _sendMessage(
                                  sessionId: widget.sessionId,
                                  userInput: _controller.text.trim(),
                                  messages: messageHistory,
                                )
                            : null,
                        child: isSendingMessage
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : SvgPicture.asset('assets/icons/send.svg'),
                      ),
                    ),
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
