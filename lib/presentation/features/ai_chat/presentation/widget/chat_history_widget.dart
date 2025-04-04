import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class ChatHistoryWidget extends StatelessWidget {
  const ChatHistoryWidget({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: colorScheme.cardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          SvgPicture.asset('assets/icons/message.svg'),
          const HorizontalSpacing(10),
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.6,
            child: Text(
              message,
              style: context.textTheme.s13w400.copyWith(
                color: colorScheme.colorScheme.onSurface,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}
