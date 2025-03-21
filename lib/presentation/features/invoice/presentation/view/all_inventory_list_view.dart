import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/presentation/features/inventory/presentation/notifier/get_all_inventory_notifier.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/get_access_token_notifier.dart';
import 'package:laxmii_app/presentation/general_widgets/laxmii_app_bar.dart';

class AllInventoryListView extends ConsumerStatefulWidget {
  const AllInventoryListView({super.key});
  static const routeName = '/allInventoryListView';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AllInventoryListViewState();
}

class _AllInventoryListViewState extends ConsumerState<AllInventoryListView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(getAccessTokenNotifier.notifier).accessToken();
      await ref
          .read(getAllInventoryNotifierProvider.notifier)
          .getAllInventory();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final inventoryList = ref
        .watch(getAllInventoryNotifierProvider
            .select((v) => v.getAllInventory.data?.inventory ?? []))
        .toList();
    return Scaffold(
      appBar: const LaxmiiAppBar(
        title: 'Inventory',
        centerTitle: true,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(
          itemCount: inventoryList.length,
          itemBuilder: (context, index) {
            final data = inventoryList[index];
            return ListTile(
              title: Text(data.productName ?? ''),
              subtitle: Text(data.description ?? ''),
            );
          },
        ),
      )),
    );
  }
}
