import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/extensions/build_context_extension.dart';
import 'package:laxmii_app/core/extensions/overlay_extension.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/core/theme/theme_provider.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/data/local_data_source/local_storage_impl.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/settings/data/model/logout_request.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/settings/data/model/notifications_model.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/settings/data/model/update_settings_request.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/settings/presentation/notifier/get_settings_notifier.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/settings/presentation/notifier/logout_notifier.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/settings/presentation/notifier/update_settings_notifier.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/settings/presentation/widgets/connect_spotify_button_widget.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/settings/presentation/widgets/notifications_options_widget.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/settings/presentation/widgets/settings_options_button.dart';
import 'package:laxmii_app/presentation/features/login/presentation/login_view.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/get_user_details_notifier.dart';
import 'package:laxmii_app/presentation/features/manage_account/presentation/view/manage_account_view.dart';
import 'package:laxmii_app/presentation/general_widgets/page_loader.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class SettingsView extends ConsumerStatefulWidget {
  const SettingsView({super.key});

  @override
  ConsumerState<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends ConsumerState<SettingsView> {
  String useruId = '';

  @override
  void initState() {
    // getUserId();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(settingsNotifer.notifier).getSettings();
      ref.read(getUserDetailsNotifier.notifier).getUserDetails();
    });
    super.initState();
  }

  getUserId() async {
    final id = await AppDataStorage().getUserId();

    setState(() {
      useruId = id ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        ref.watch(logOutNotifer.select((v) => v.logOut.isLoading));
    final settings = ref.watch(settingsNotifer.select((v) => v.data));
    final userId =
        ref.watch(getUserDetailsNotifier.select((v) => v.data?.userId ?? ''));
    final isLightTheme = ref.watch(themeProvider);
    final colorScheme = Theme.of(context);
    return PageLoader(
      isLoading: isLoading,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: colorScheme.appBarTheme.backgroundColor,
            automaticallyImplyLeading: false,
            centerTitle: false,
            foregroundColor: colorScheme.appBarTheme.foregroundColor,
            title: Text(
              'Settings',
              style: context.textTheme.s20w500.copyWith(
                color: colorScheme.colorScheme.onSurface,
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
                    'Profile Informations',
                    style: context.textTheme.s14w500.copyWith(
                        color: colorScheme.colorScheme.tertiary,
                        fontWeight: FontWeight.w300),
                  ),
                  const VerticalSpacing(6),
                  GestureDetector(
                    onTap: () => context.pushNamed(ManageAccountView.routeName),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: colorScheme.cardColor),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Manage Account',
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
                    ),
                  ),
                  const VerticalSpacing(24),
                  const Divider(
                    color: AppColors.primary5E5E5E,
                  ),
                  const VerticalSpacing(24),
                  NotificationsOptionsWidget(
                    title: 'Change Theme',
                    onChanged: (v) {
                      ref.read(themeProvider.notifier).state = v;
                    },
                    value: isLightTheme,
                  ),
                  const VerticalSpacing(24),
                  Text(
                    'Notifications',
                    style: context.textTheme.s14w500.copyWith(
                        color: colorScheme.colorScheme.tertiary,
                        fontWeight: FontWeight.w300),
                  ),
                  const VerticalSpacing(6),
                  NotificationsOptionsWidget(
                    title: 'To-do Notification',
                    onChanged: (v) {
                      setState(() {
                        settings?.settings?.notifications?.todoNotification = v;
                      });

                      final notifications = settings?.settings?.notifications;
                      if (notifications != null) {
                        _updateSettings(notifications);
                      }
                    },
                    value:
                        settings?.settings?.notifications?.todoNotification ??
                            false,
                  ),
                  const VerticalSpacing(10),
                  NotificationsOptionsWidget(
                    title: 'Tax Optimization',
                    onChanged: (v) {
                      setState(() {
                        settings?.settings?.notifications?.taxOptimization = v;
                      });

                      final notifications = settings?.settings?.notifications;
                      if (notifications != null) {
                        _updateSettings(notifications);
                      }
                    },
                    value: settings?.settings?.notifications?.taxOptimization ??
                        false,
                  ),
                  const VerticalSpacing(10),
                  NotificationsOptionsWidget(
                    title: 'Inventory Alerts',
                    onChanged: (v) {
                      setState(() {
                        settings?.settings?.notifications?.inventoryAlerts = v;
                      });

                      final notifications = settings?.settings?.notifications;
                      if (notifications != null) {
                        _updateSettings(notifications);
                      }
                    },
                    value: settings?.settings?.notifications?.inventoryAlerts ??
                        false,
                  ),
                  const VerticalSpacing(10),
                  NotificationsOptionsWidget(
                    title: 'Performance Insight',
                    onChanged: (v) {
                      setState(() {
                        settings?.settings?.notifications?.performanceInsight =
                            v;
                      });

                      final notifications = settings?.settings?.notifications;
                      if (notifications != null) {
                        _updateSettings(notifications);
                      }
                    },
                    value:
                        settings?.settings?.notifications?.performanceInsight ??
                            false,
                  ),
                  const VerticalSpacing(24),
                  const Divider(
                    color: AppColors.primary5E5E5E,
                  ),
                  const VerticalSpacing(20),
                  ConnectSpotifyButtonWidget(
                    isConnected: settings?.settings?.shopifyConnected ?? false,
                    userId: userId,
                  ),
                  const VerticalSpacing(20),
                  const Divider(
                    color: AppColors.primary5E5E5E,
                  ),
                  // const VerticalSpacing(30),
                  // Text(
                  //   'Currency',
                  //   style: context.textTheme.s14w500.copyWith(
                  //       color: colorScheme.colorScheme.tertiary,
                  //       fontWeight: FontWeight.w300),
                  // ),
                  // const VerticalSpacing(6),
                  // GestureDetector(
                  //   onTap: () {},
                  //   child: const SettingsOptionsButton(
                  //     title: 'US Dollar (\$)',
                  //     icon: Icons.keyboard_arrow_down,
                  //     textColor: AppColors.primary5E5E5E,
                  //   ),
                  // ),
                  const VerticalSpacing(20),
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

  void _updateSettings(Notifications notifications) {
    final data = UpdateSettingsRequest(notifications: notifications);
    ref.read(updateSettingsNotifer.notifier).updateSettings(
        data: data,
        onError: (error) {
          context.showError(message: error);
        },
        onSuccess: (message) {
          context.showSuccess(message: message);
          ref.read(settingsNotifer.notifier).getSettings();
        });
  }

  void _logout() async {
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
