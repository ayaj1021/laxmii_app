import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class SpotifyPage extends ConsumerStatefulWidget {
  const SpotifyPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SpotifyPageState();
}

class _SpotifyPageState extends ConsumerState<SpotifyPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset('assets/icons/empty_data.svg'),
        const VerticalSpacing(10),
        Text(
          'No data Available',
          style: context.textTheme.s14w500.copyWith(
            color: AppColors.white,
          ),
        ),
      ],
    );
  }
}
