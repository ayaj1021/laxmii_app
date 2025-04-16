import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/activity/presentation/view/activity.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/home/presentation/view/home.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/settings/presentation/view/settings_view.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/tools/tools_view.dart';
import 'package:laxmii_app/presentation/features/dashboard/widgets/bottom_nav.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/get_access_token_notifier.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/get_user_details_notifier.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({super.key});
  static const routeName = '/dashboard';

  @override
  ConsumerState<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(getAccessTokenNotifier.notifier).accessToken();
      await ref.read(getUserDetailsNotifier.notifier).getUserDetails();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: ref.watch(currentIndexProvider),
        children: const [
          HomeView(),
          ActivityView(),
          SizedBox.shrink(),
          ToolsView(),
          SettingsView(),
        ],
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
