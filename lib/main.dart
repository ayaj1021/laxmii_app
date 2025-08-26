import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laxmii_app/core/navigation/router.dart';
import 'package:laxmii_app/core/theme/app_theme.dart';
import 'package:laxmii_app/core/theme/theme_provider.dart';
import 'package:laxmii_app/data/local_data_source/local_storage_impl.dart';
import 'package:laxmii_app/firebase_options.dart';
import 'package:laxmii_app/presentation/general_widgets/app_overlay.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _controller = OverLayController();

  @override
  void initState() {
    _initializeTheme();
    super.initState();
  }

  // getAppTheme() async {
  //   final theme = await AppDataStorage().getAppTheme();
  //   setState(() {
  //     appTheme = theme;
  //   });
  // }

  _initializeTheme() async {
    final theme = await AppDataStorage().getAppTheme();
    if (mounted) {
      // Initialize the provider with stored value
      final container = ProviderScope.containerOf(context);
      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
      container.read(themeProvider.notifier).state = theme;
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final isLightTheme = ref.watch(themeProvider);
      return ScreenUtilInit(
          designSize: const Size(360, 800),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, c) {
            return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: AppOverLay(
                  controller: _controller,
                  child: MaterialApp(
                    theme: isLightTheme
                        ? AppThemes.lightTheme()
                        : AppThemes.darkTheme(),
                    //  darkTheme: AppThemes.darkTheme(),
                    debugShowCheckedModeBanner: false,
                    routes: AppRouter.routes,
                    initialRoute: '/',
                  ),
                ),
              ),
            );
          });
    });
  }
}
