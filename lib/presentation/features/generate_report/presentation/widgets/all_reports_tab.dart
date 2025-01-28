import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/extensions/build_context_extension.dart';
import 'package:laxmii_app/core/extensions/overlay_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/generate_report/data/model/add_report_to_favorite_request.dart';
import 'package:laxmii_app/presentation/features/generate_report/data/model/delete_report_favorite_request.dart';
import 'package:laxmii_app/presentation/features/generate_report/presentation/notifier/add_report_to_favorite_notifier.dart';
import 'package:laxmii_app/presentation/features/generate_report/presentation/notifier/delete_report_favorite_notifier.dart';
import 'package:laxmii_app/presentation/features/generate_report/presentation/notifier/get_all_reports_notifier.dart';
import 'package:laxmii_app/presentation/features/generate_report/presentation/notifier/get_favorite_reports_notifier.dart';
import 'package:laxmii_app/presentation/features/generate_report/presentation/view/generate_report.dart';
import 'package:laxmii_app/presentation/features/generate_report/presentation/view/sales_report_detail.dart';
import 'package:laxmii_app/presentation/features/generate_report/presentation/widgets/reports_widget.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/get_access_token_notifier.dart';
import 'package:laxmii_app/presentation/general_widgets/page_loader.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class AllReportsTab extends ConsumerStatefulWidget {
  const AllReportsTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AllReportsTabState();
}

class _AllReportsTabState extends ConsumerState<AllReportsTab> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(getAccessTokenNotifier.notifier).accessToken();
      await ref.read(getAllReportsNotifierProvider.notifier).getAllReports();
      await ref
          .read(getFavoriteReportsNotifierProvider.notifier)
          .getAllFavoriteReports();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final reportsList = ref.watch(
        getAllReportsNotifierProvider.select((v) => v.getAllReports.data));

    final favoriteReport = ref.watch(getFavoriteReportsNotifierProvider
        .select((v) => v.getAllFavoriteReports.data?.favServices ?? []));

    final isAdded =
        ref.watch(addReportsToFavoriteNotifier.select((v) => v.isAdded));

    final isFavoriteLoading = ref.watch(addReportsToFavoriteNotifier
        .select((v) => v.addReportToFavoriteState.isLoading));

    return PageLoader(
      isLoading: isFavoriteLoading,
      child: SizedBox(
        child: reportsList == null
            ? const SizedBox.shrink()
            : ListView.builder(
                itemCount: reportsList.modelsWithData?.length,
                itemBuilder: (context, index) {
                  final data = reportsList.modelsWithData?[index];
                  final count = reportsList.modelsWithData?.length;
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SalesReportDetail(
                            reportType: '$data',
                          ),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        ReportsWidget(
                          report: '$data',
                          color: favoriteReport.contains(data?.toLowerCase())
                              ? AppColors.primaryColor
                              : AppColors.primary5E5E5E,
                          onTap: () {
                            favoriteReport.contains(data?.toLowerCase()) == true
                                ? _removeFavorite(service: '$data')
                                : _addToFavorite(service: '$data');
                          },
                          isFavorite: index == index ? isAdded : false,
                        ),
                        const VerticalSpacing(10),
                        if (index < (count ?? 0) - 1)
                          Divider(
                            color: AppColors.primary5E5E5E.withOpacity(0.5),
                          ),
                        const VerticalSpacing(10),
                      ],
                    ),
                  );
                }),
      ),
    );
  }

  void _addToFavorite({required String service}) {
    final data = AddReportToFavoriteRequest(service: service.toLowerCase());
    ref.read(addReportsToFavoriteNotifier.notifier).addReportToFavorite(
        data: data,
        onError: (error) {
          context.showError(message: error);
        },
        onSuccess: (message) {
          context.showSuccess(message: message);
          context.popAndPushNamed(GenerateReport.routeName);
        });
  }

  void _removeFavorite({required String service}) {
    final data = DeleteReportFavoriteRequest(service: service.toLowerCase());
    ref.read(deleteReportFavoriteNotifier.notifier).deleteReportFavorite(
        data: data,
        onError: (error) {
          context.showError(
            message: error,
          );
        },
        onSuccess: (message) {
          context.showSuccess(
            message: message,
          );
          context.popAndPushNamed(GenerateReport.routeName);
        });
  }
}
