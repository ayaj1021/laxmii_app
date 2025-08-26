import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laxmii_app/core/extensions/overlay_extension.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/features/ai_chat/presentation/notifier/get_recent_chat_history_notifier.dart';
import 'package:laxmii_app/presentation/features/ai_chat/presentation/notifier/start_new_chat_notifier.dart';
import 'package:laxmii_app/presentation/features/ai_chat/presentation/view/chat_view.dart';
import 'package:laxmii_app/presentation/features/ai_chat/presentation/widget/chat_history_widget.dart';
import 'package:laxmii_app/presentation/general_widgets/app_button.dart';
import 'package:laxmii_app/presentation/general_widgets/laxmii_app_bar.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class AiAssistant extends ConsumerStatefulWidget {
  const AiAssistant({super.key});
  static const String routeName = '/aiAssistant';
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AiAssistantState();
}

class _AiAssistantState extends ConsumerState<AiAssistant> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.read(getRecentChatsNotifier.notifier).getRecentChatHistory();
      await ref.read(startChatNotifier.notifier).startNewChat(
        onError: (error) {
          context.showError(message: error);
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final recentChats = ref.watch(getRecentChatsNotifier.select((v) =>
        v.data?.recentChats
            ?.where((e) => e.lastMessage?.message?.isNotEmpty ?? false)
            .toList() ??
        []));
    final sessionId = ref.watch(startChatNotifier
        .select((v) => v.startNewChatResponse.data?.sessionId));
    final colorScheme = Theme.of(context);
    return Scaffold(
      appBar: const LaxmiiAppBar(
        title: 'AI Assistant',
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              const VerticalSpacing(80),
              SizedBox(
                height: 66.h,
                width: 89.w,
                child: Image.asset('assets/logo/laxmii_logo.png'),
              ),
              const VerticalSpacing(28),
              Text(
                'Welcome to AI Chat',
                style: context.textTheme.s20w500.copyWith(
                  color: colorScheme.colorScheme.onSurface,
                ),
              ),
              const VerticalSpacing(10),
              Text(
                'Start chatting with  AI Chat now.',
                style: context.textTheme.s12w400.copyWith(
                  color: AppColors.primary5E5E5E,
                ),
              ),
              const VerticalSpacing(40),
              LaxmiiSendButton(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChatView(
                          sessionId: sessionId ?? '',
                        ),
                      ),
                    );
                  },
                  title: 'New Chat'),
              const VerticalSpacing(30),
              if (recentChats.isNotEmpty)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Previous 7 days',
                    style: context.textTheme.s16w500.copyWith(
                      color: AppColors.primary5E5E5E,
                    ),
                  ),
                ),
              const VerticalSpacing(20),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.6,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: recentChats.length < 6 ? recentChats.length : 6,
                    itemBuilder: (_, index) {
                      final data = recentChats[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ChatView(
                                        sessionId: data.sessionId ?? '',
                                      )));
                        },
                        child: Column(
                          children: [
                            if (data.lastMessage?.message != null)
                              ChatHistoryWidget(
                                message: data.lastMessage?.message ?? '',
                              ),
                            const VerticalSpacing(10)
                          ],
                        ),
                      );
                    }),
              )
            ],
          ),
        )),
      ),
    );
  }
}
