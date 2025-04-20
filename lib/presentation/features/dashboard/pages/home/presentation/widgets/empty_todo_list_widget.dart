import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:laxmii_app/core/extensions/build_context_extension.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/presentation/features/todo/presentation/view/create_task_view.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class EmptyTodoListWidget extends StatelessWidget {
  const EmptyTodoListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context);
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: DottedBorder(
          strokeWidth: 2.5,
          radius: const Radius.circular(10),
          color: colorScheme.cardColor,
          padding:
              const EdgeInsets.only(top: 70, right: 60, left: 60, bottom: 90),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'No task added yet',
                style: context.textTheme.s14w600.copyWith(
                  color: colorScheme.colorScheme.onSurface,
                ),
              ),
              const VerticalSpacing(2),
              GestureDetector(
                onTap: () {
                  context.pushNamed(CreateTaskView.routeName);
                },
                child: Text(
                  'Tap the + button to create your first  task',
                  style: context.textTheme.s12w300.copyWith(
                    color: colorScheme.colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
