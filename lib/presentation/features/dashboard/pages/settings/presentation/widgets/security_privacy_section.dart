import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/settings/presentation/notifier/enable_face_id_notifier.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class SecurityPrivacySection extends ConsumerWidget {
  const SecurityPrivacySection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(enableFaceIdProvider);
    final colorScheme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: colorScheme.cardColor,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Change Passcode',
                style: context.textTheme.s14w500.copyWith(
                  color: AppColors.primary5E5E5E,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: colorScheme.iconTheme.color,
                size: 18,
              )
            ],
          ),
          const VerticalSpacing(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Enable Face ID',
                style: context.textTheme.s14w500.copyWith(
                  color: AppColors.primary5E5E5E,
                ),
              ),
              Transform.scale(
                scaleY: 1,
                scaleX: 1,
                child: Switch(
                    activeTrackColor: AppColors.primaryColor,
                    inactiveTrackColor: colorScheme.cardColor,
                    value: value,
                    onChanged: (newValue) async {
                      await ref.read(enableFaceIdProvider.notifier).toggle();
                    }),
              )
            ],
          ),
        ],
      ),
    );
  }
}
