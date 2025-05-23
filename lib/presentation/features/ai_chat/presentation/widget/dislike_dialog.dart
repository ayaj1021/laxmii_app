import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/extensions/overlay_extension.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/ai_chat/data/model/send_report_request.dart';
import 'package:laxmii_app/presentation/features/ai_chat/presentation/notifier/send_ai_report_notifier.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class DislikeDialog extends ConsumerStatefulWidget {
  const DislikeDialog(
      {super.key, required this.sessionId, required this.messageId});
  final String sessionId;
  final String messageId;

  @override
  ConsumerState<DislikeDialog> createState() => _DislikeDialogState();
}

class _DislikeDialogState extends ConsumerState<DislikeDialog> {
  final _reportController = TextEditingController();
  String? selectedTag;
  @override
  Widget build(BuildContext context) {
    final isLoading =
        ref.watch(sendAiReportNotifier.select((v) => v.state.isLoading));
    final colorScheme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: colorScheme.cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Feedback',
            style: context.textTheme.s15w400.copyWith(
                color: colorScheme.colorScheme.tertiary, fontSize: 18),
          ),
          const VerticalSpacing(14),
          Wrap(
            spacing: 5,
            runSpacing: 12,
            children: List.generate(
              tags.length,
              (index) => _buildTag(tags[index], () {
                setState(() {
                  selectedTag = tags[index];
                });
              }),
            ),

            //  tags.map((tag) => _buildTag(tag)).toList(),
          ),
          const VerticalSpacing(14),
          Container(
            //  padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFF5E5E5E),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              controller: _reportController,
              maxLines: 5,
              minLines: 1,
              decoration: InputDecoration(
                hintText:
                    'We appreciate your feedback. Please share any comments or suggestions that you have to help us improve.',
                hintStyle: context.textTheme.s12w400.copyWith(
                  color: colorScheme.colorScheme.onSurface,
                ),
                border: InputBorder.none,
                fillColor: Colors.transparent,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),
          const VerticalSpacing(21),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: context.textTheme.s15w400.copyWith(
                    color: colorScheme.colorScheme.tertiary,
                  ),
                ),
              ),
              const HorizontalSpacing(10),
              GestureDetector(
                onTap: () {
                  if (selectedTag == null) {
                    context.showError(message: 'Please select a tag');
                    return;
                  }
                  _sendReport();
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    isLoading ? 'Submitting...' : 'Submit',
                    style: context.textTheme.s15w400.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String label, Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4.5),
        decoration: BoxDecoration(
          color: const Color(0xFF555561), // dark grey from your image
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            width: 2,
            color: selectedTag == label
                ? AppColors.primaryColor
                : const Color(0xFF555561),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  void _sendReport() {
    final data = SendReportRequest(
        sessionId: widget.sessionId,
        messageId: widget.messageId,
        flagType: selectedTag?.toLowerCase() ?? '',
        customMessage: _reportController.text.trim());

    ref.read(sendAiReportNotifier.notifier).sendAiReport(
          request: data,
          onError: (error) {
            context.showError(message: error);
          },
          onSuccess: (message) {
            context.showSuccess(message: message);
            Navigator.pop(context);
          },
        );
  }
}

final List<String> tags = [
  'Harmful',
  'Fake',
  'Unhelpful',
  'Others',
];
