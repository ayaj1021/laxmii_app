import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/presentation/features/generate_report/presentation/widgets/inventory_table_section.dart';
import 'package:laxmii_app/presentation/features/inventory/presentation/notifier/get_all_inventory_notifier.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/get_access_token_notifier.dart';
import 'package:laxmii_app/presentation/general_widgets/laxmii_app_bar.dart';

class InventoryReportDetailReport extends ConsumerStatefulWidget {
  const InventoryReportDetailReport({super.key, required this.reportType});
  final String reportType;

  @override
  ConsumerState<InventoryReportDetailReport> createState() =>
      _InventoryReportDetailReportState();
}

class _InventoryReportDetailReportState
    extends ConsumerState<InventoryReportDetailReport> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref
          .read(getAllInventoryNotifierProvider.notifier)
          .getAllInventory();

      await ref.read(getAccessTokenNotifier.notifier).accessToken();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final reports = ref.watch(getAllInventoryNotifierProvider
        .select((v) => v.getAllInventory.data?.inventory ?? []));
    return Scaffold(
      appBar: LaxmiiAppBar(
        centerTitle: true,
        title: '${widget.reportType} Report',
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            InventoryTableSection(
              report: reports,
            )
          ],
        ),
      )),
    );
  }
}
