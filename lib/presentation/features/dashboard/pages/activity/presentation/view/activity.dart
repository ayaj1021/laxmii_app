import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/activity/presentation/components/cashflow.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/activity/presentation/widgets/pop_up_menu_button_widget.dart';

class ActivityView extends ConsumerWidget {
  const ActivityView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        backgroundColor: Colors.transparent,
        title: Text(
          'Activity',
          style: context.textTheme.s24w400.copyWith(
            color: AppColors.primaryC4C4C4,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: const [PopUpMenuButtonWidget()],
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              children: [
                Cashflow(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
