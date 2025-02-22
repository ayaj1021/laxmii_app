import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/extensions/build_context_extension.dart';
import 'package:laxmii_app/core/extensions/overlay_extension.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/data/local_data_source/local_storage_impl.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/settings/data/model/logout_request.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/settings/presentation/notifier/logout_notifier.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/settings/presentation/widgets/notifications_options_widget.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/settings/presentation/widgets/settings_options_button.dart';
import 'package:laxmii_app/presentation/features/login/presentation/login_view.dart';
import 'package:laxmii_app/presentation/general_widgets/page_loader.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class SettingsView extends ConsumerStatefulWidget {
  const SettingsView({super.key});

  @override
  ConsumerState<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends ConsumerState<SettingsView> {
  bool todoNotification = false;
  bool taxOptimization = false;
  bool inventoryAlerts = false;
  bool performanceInsights = false;
  @override
  Widget build(BuildContext context) {
    final isLoading =
        ref.watch(logOutNotifer.select((v) => v.logOut.isLoading));
    return PageLoader(
      isLoading: isLoading,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            centerTitle: false,
            title: Text(
              'Settings',
              style: context.textTheme.s20w500.copyWith(
                color: AppColors.white,
              ),
            ),
          ),
          body: SafeArea(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Profile Information',
                    style: context.textTheme.s14w500.copyWith(
                        color: AppColors.primaryC4C4C4,
                        fontWeight: FontWeight.w300),
                  ),
                  const VerticalSpacing(6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.primary101010),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Manage Account',
                          style: context.textTheme.s14w500.copyWith(
                            color: AppColors.primary5E5E5E,
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.primaryC4C4C4,
                          size: 18,
                        )
                      ],
                    ),
                  ),
                  const VerticalSpacing(24),
                  const Divider(
                    color: AppColors.primary5E5E5E,
                  ),
                  const VerticalSpacing(24),
                  Text(
                    'Notifications',
                    style: context.textTheme.s14w500.copyWith(
                        color: AppColors.primaryC4C4C4,
                        fontWeight: FontWeight.w300),
                  ),
                  const VerticalSpacing(6),
                  NotificationsOptionsWidget(
                    title: 'To-do Notification',
                    onChanged: (v) {
                      setState(() {
                        todoNotification = v;
                      });
                    },
                    value: todoNotification,
                  ),
                  const VerticalSpacing(10),
                  NotificationsOptionsWidget(
                    title: 'Tax Optimization',
                    onChanged: (v) {
                      setState(() {
                        taxOptimization = v;
                      });
                    },
                    value: taxOptimization,
                  ),
                  const VerticalSpacing(10),
                  NotificationsOptionsWidget(
                    title: 'Inventory Alerts',
                    onChanged: (v) {
                      setState(() {
                        inventoryAlerts = v;
                      });
                    },
                    value: inventoryAlerts,
                  ),
                  const VerticalSpacing(10),
                  NotificationsOptionsWidget(
                    title: 'Performance Insight',
                    onChanged: (v) {
                      setState(() {
                        performanceInsights = v;
                      });
                    },
                    value: performanceInsights,
                  ),
                  const VerticalSpacing(30),
                  Text(
                    'Currency',
                    style: context.textTheme.s14w500.copyWith(
                        color: AppColors.primaryC4C4C4,
                        fontWeight: FontWeight.w300),
                  ),
                  const VerticalSpacing(6),
                  GestureDetector(
                    onTap: () {},
                    child: const SettingsOptionsButton(
                      title: 'US Dollar (\$)',
                      icon: Icons.keyboard_arrow_down,
                      textColor: AppColors.primary5E5E5E,
                    ),
                  ),
                  const VerticalSpacing(48),
                  GestureDetector(
                    onTap: () => _logout(),
                    child: const SettingsOptionsButton(
                      title: 'Logout',
                      icon: Icons.arrow_forward_ios,
                      textColor: AppColors.primaryFF5733,
                    ),
                  ),
                ],
              ),
            ),
          ))),
    );
  }

  void _logout() async {
    // await AppDataStorage().clearToken();
    // context.pushReplacementNamed(LoginView.routeName);
    final refreshToken = await AppDataStorage().getUserRefreshToken();
    final data = LogoutRequest(refreshToken: refreshToken.toString());
    ref.read(logOutNotifer.notifier).logOut(
        data: data,
        onError: (error) {
          context.showError(message: error);
        },
        onSuccess: (message) async {
          context.hideOverLay();
          context.showSuccess(message: message);
          context.pushReplacementNamed(LoginView.routeName);
          await AppDataStorage().clearToken();
        });
  }
}
