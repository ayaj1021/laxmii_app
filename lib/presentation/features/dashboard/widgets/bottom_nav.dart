import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laxmii_app/core/extensions/space_extension.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/home_bottom_nav.dart';

class NavBar extends ConsumerWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context);
    // ref.listen(
    //   logoutProvider,
    //   (previous, next) {
    //     if (next == ActivityStatus.loggedOut) {
    //       context.replaceAll(Login.routeName);
    //     }
    //   },
    // );
    final items = [
      'Home',
      'Activity',
      '',
      'Tools',
      'Settings',
    ];
    final v = ref.watch(currentIndexProvider);
    return Container(
      padding: EdgeInsets.fromLTRB(
        5,
        21.h,
        5,
        10,
      ),
      decoration: BoxDecoration(
        color: colorScheme.scaffoldBackgroundColor,
        //borderRadius: BorderRadius.circular(30),
      ),
      width: double.infinity,
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            items.length,
            (index) => Expanded(
              child: InkWell(
                onTap: () {
                  ref.read(currentIndexProvider.notifier).state = index;
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  transform: Matrix4.identity()..scale(index == v ? 1.02 : 1.0),
                  child: index == 2
                      ? GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (_) {
                                  return const HomeBottomNav();
                                });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                                color: AppColors.primaryColor,
                                shape: BoxShape.circle),
                            child: Icon(
                              Icons.add,
                              color: colorScheme.scaffoldBackgroundColor,
                            ),
                          ),
                        )
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/${index == v ? '${items[index].toLowerCase()}-filled' : items[index].toLowerCase()}.svg',
                            ),
                            5.hSpace,
                            Text(
                              items[index],
                              style: context.textTheme.s12w400.copyWith(
                                color: index == v
                                    ? AppColors.primaryColor
                                    : AppColors.primaryA29FB3,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

final currentIndexProvider = StateProvider<int>((ref) => 0);
