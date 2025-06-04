import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:laxmii_app/presentation/features/ai_chat/presentation/notifier/get_recent_chat_history_notifier.dart';
import 'package:laxmii_app/presentation/features/ai_chat/presentation/notifier/start_new_chat_notifier.dart';
import 'package:laxmii_app/presentation/features/ai_chat/presentation/widget/ai_message_card.dart';
import 'package:laxmii_app/presentation/features/ai_chat/presentation/widget/dislike_dialog.dart';
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

  // Track local messages for immediate UI updates
  List<AiChatMessages> _localMessages = [];
  bool _isInitialized = false;

  // Track disliked messages
  final Set<String> _dislikedMessageIds = {};

  @override
  void initState() {
    super.initState();
    _initializeChat();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _initializeChat() async {
    // Initialize chat session
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

      // Mark as initialized and scroll to bottom
      setState(() {
        _isInitialized = true;
      });

      // Scroll to bottom after loading chat history
      _scrollToBottomDelayed();
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
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _scrollToBottomDelayed() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  Future<void> _sendMessage({
    required String sessionId,
    required String userInput,
  }) async {
    if (userInput.trim().isEmpty) return;

    final trimmedInput = userInput.trim();
    final data = ChatAiRequest(sessionId: sessionId, userInput: trimmedInput);

    // Add user message to local state immediately for instant UI feedback
    final userMessage = AiChatMessages(
      message: trimmedInput,
      sender: 'user',
      id: DateTime.now().millisecondsSinceEpoch.toString(), // Temporary ID
    );

    setState(() {
      _localMessages = [..._localMessages, userMessage];
    });

    // Clear input and scroll to show new message
    _controller.clear();
    _scrollToBottomDelayed();

    // Send message to server
    await ref.read(chatAiNotifier.notifier).chatAi(
          data: data,
          onError: (error) {
            // Remove the optimistic message on error
            setState(() {
              _localMessages = _localMessages
                  .where((msg) => msg.id != userMessage.id)
                  .toList();
            });
            context.showError(message: error);
          },
          onSuccess: () async {
            // Clear local messages since server will have the updated conversation
            setState(() {
              _localMessages = [];
            });

            // Refresh chat history from server
            await _getChatHistory();

            // Scroll to bottom to show AI response
            _scrollToBottomDelayed();
          },
        );
  }

  List<AiChatMessages> _getCombinedMessages(
      List<AiChatMessages> serverMessages) {
    // Combine server messages with local optimistic messages
    final combined = [...serverMessages];

    // Add any local messages that aren't yet on the server
    for (final localMsg in _localMessages) {
      // Only add if not already in server messages
      final exists = serverMessages.any((serverMsg) =>
          serverMsg.message == localMsg.message &&
          serverMsg.sender == localMsg.sender);
      if (!exists) {
        combined.add(localMsg);
      }
    }

    return combined;
  }

  @override
  Widget build(BuildContext context) {
    final sessionId = ref.watch(startChatNotifier
        .select((v) => v.startNewChatResponse.data?.sessionId));

    final serverMessages = ref.watch(getChatHistoryNotifier
        .select((v) => v.getChatHistoryResponse.data?.messages ?? []));

    final isSendingMessage = ref.watch(
      chatAiNotifier.select((v) => v.loadState.isLoading),
    );

    final colorScheme = Theme.of(context);

    // Combine server messages with local optimistic messages
    final allMessages = _getCombinedMessages(serverMessages);

    // Auto-scroll to bottom when messages change (after initial load)
    if (_isInitialized && allMessages.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          final currentScrollPos = _scrollController.position.pixels;
          final maxScrollExtent = _scrollController.position.maxScrollExtent;

          // Only auto-scroll if user is near the bottom (within 100 pixels)
          if (maxScrollExtent - currentScrollPos < 100) {
            _scrollToBottom();
          }
        }
      });
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: LaxmiiAppBar(
        // ref.read(getRecentChatsNotifier.notifier).getRecentChatHistory();
        leading: InkWell(
          onTap: () {
            ref.read(getRecentChatsNotifier.notifier).getRecentChatHistory();
            Navigator.pop(context);
          },
          child: SvgPicture.asset(
            'assets/icons/arrowleft.svg',
            fit: BoxFit.scaleDown,
            colorFilter: ColorFilter.mode(
                colorScheme.colorScheme.onSurface, BlendMode.srcIn),
          ),
        ),
        title: 'AI Assistant',
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: allMessages.isEmpty
                  ? Center(
                      child: Text(
                        'Start a conversation',
                        style: TextStyle(
                          color: colorScheme.colorScheme.onSurface
                              .withValues(alpha: 0.6),
                          fontSize: 16,
                        ),
                      ),
                    )
                  : ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.only(
                        top: 10,
                        bottom: 20,
                        left: 10,
                        right: 10,
                      ),
                      itemCount: allMessages.length,
                      itemBuilder: (_, index) {
                        final message = allMessages[index];

                        if (message.sender == 'user') {
                          return UserChatCard(
                            message: message.message ?? '',
                            type: message.sender.toString(),
                          );
                        } else if ((message.sender ?? '').contains('ai')) {
                          return AiMessageCard(
                            type: message.sender.toString(),
                            message: message.message ?? '',
                            onCopyTapped: () {
                              copyToClipboard(message.message ?? '');
                              context.showToast(
                                message: 'Copied to clipboard',
                              );
                            },
                            isDisliked:
                                _dislikedMessageIds.contains(message.id),
                            onDislikeTapped: () {
                              showDialog(
                                context: context,
                                builder: (_) => Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: DislikeDialog(
                                    sessionId: widget.sessionId,
                                    messageId: message.id ?? '',
                                  ),
                                ),
                              ).then((_) {
                                setState(() {
                                  _dislikedMessageIds.add(message.id ?? '');
                                });
                              });
                            },
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
                                _controller.text.trim().isNotEmpty &&
                                !isSendingMessage
                            ? () => _sendMessage(
                                  sessionId: widget.sessionId,
                                  userInput: _controller.text.trim(),
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

  void copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }
}
