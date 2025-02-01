import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laxmii_app/core/extensions/string_extensions.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/features/generate_report/presentation/notifier/get_favorite_reports_notifier.dart';
import 'package:laxmii_app/presentation/features/generate_report/presentation/view/sales_report_detail.dart';
import 'package:laxmii_app/presentation/features/generate_report/presentation/widgets/reports_widget.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/get_access_token_notifier.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class FavoritesTab extends ConsumerStatefulWidget {
  const FavoritesTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FavoritesTabState();
}

class _FavoritesTabState extends ConsumerState<FavoritesTab> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(getAccessTokenNotifier.notifier).accessToken();
      await ref
          .read(getFavoriteReportsNotifierProvider.notifier)
          .getAllFavoriteReports();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final favoriteReport = ref.watch(getFavoriteReportsNotifierProvider
        .select((v) => v.getAllFavoriteReports.data?.favServices ?? []));
    return favoriteReport.isEmpty
        ? Column(
            children: [
              SvgPicture.asset('assets/icons/empty_data.svg'),
              const VerticalSpacing(10),
              Text(
                'No Favorite Report Yet',
                style: context.textTheme.s14w500.copyWith(
                  color: AppColors.white,
                ),
              ),
            ],
          )
        : SizedBox(
            child: ListView.builder(
                itemCount: favoriteReport.length,
                itemBuilder: (context, index) {
                  final data = favoriteReport[index];
                  final count = favoriteReport.length;
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SalesReportDetail(
                            reportType: data,
                          ),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        ReportsWidget(
                          report: data.capitalize,
                          isFavorite: false,
                        ),
                        const VerticalSpacing(10),
                        if (index < (count) - 1)
                          Divider(
                            color:
                                AppColors.primary5E5E5E.withValues(alpha: 0.5),
                          ),
                        const VerticalSpacing(10),
                      ],
                    ),
                  );
                }),
          );
  }
}
