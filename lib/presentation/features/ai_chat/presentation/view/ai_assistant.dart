import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laxmii_app/core/extensions/build_context_extension.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/features/ai_chat/presentation/view/chat_view.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LaxmiiAppBar(
        title: 'AI Assistant',
        centerTitle: true,
      ),
      body: SafeArea(
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
                color: AppColors.primaryC4C4C4,
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
                onTap: () => context.pushNamed(ChatView.routeName),
                title: 'New Chat')
          ],
        ),
      )),
    );
  }
}
