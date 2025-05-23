import 'package:flutter/material.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class UserChatCard extends StatelessWidget {
  const UserChatCard({super.key, required this.message, required this.type});
  final String message;
  final String type;
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context);
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width - 45,
            ),
            child: Container(
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                  color: colorScheme.dialogBackgroundColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25))),
              child: Text(
                message,
                style: context.textTheme.s14w400.copyWith(
                  color: colorScheme.colorScheme.tertiary,
                ),
              ),
            ),
          ),
        ),
        const VerticalSpacing(20)
      ],
    );
  }
}
