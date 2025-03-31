import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laxmii_app/core/navigation/router.dart';
import 'package:laxmii_app/core/theme/app_theme.dart';
import 'package:laxmii_app/core/theme/theme_provider.dart';
import 'package:laxmii_app/presentation/general_widgets/app_overlay.dart';

void main() {
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
