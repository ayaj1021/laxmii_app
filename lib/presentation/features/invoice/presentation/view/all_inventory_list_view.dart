import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/extensions/build_context_extension.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/inventory/presentation/notifier/get_all_inventory_notifier.dart';
import 'package:laxmii_app/presentation/features/inventory/presentation/view/create_inventory_view.dart';
import 'package:laxmii_app/presentation/features/invoice/presentation/notifier/add_product_notifier.dart';
import 'package:laxmii_app/presentation/features/invoice/presentation/view/add_new_invoice_view.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/get_access_token_notifier.dart';
import 'package:laxmii_app/presentation/general_widgets/empty_page.dart';
import 'package:laxmii_app/presentation/general_widgets/laxmii_app_bar.dart';
import 'package:laxmii_app/presentation/general_widgets/page_loader.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class AllInventoryListView extends ConsumerStatefulWidget {
  const AllInventoryListView({
    super.key,
    required this.addItem,
    required this.itemsNotifier,
  });
  final Function(ProductItems newItem) addItem;
  final ValueNotifier<List<ProductItems>> itemsNotifier;

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

    final isLoading = ref.watch(
        getAllInventoryNotifierProvider.select((v) => v.loadState.isLoading));
    final colorScheme = Theme.of(context);
    return Scaffold(
      appBar: const LaxmiiAppBar(
        title: 'Inventory',
        centerTitle: true,
      ),
      body: PageLoader(
        isLoading: isLoading,
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: inventoryList.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const EmptyPage(
                          emptyMessage:
                              'Inventory is empty try to create inventory'),
                      const VerticalSpacing(20),
                      GestureDetector(
                        onTap: () =>
                            context.pushNamed(CreateInventory.routeName),
                        child: Text(
                          'Create inventory',
                          style: context.textTheme.s15w600.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: inventoryList.length,
                  itemBuilder: (context, index) {
                    final data = inventoryList[index];
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            final item = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => AddNewInvoiceView(
                                  item: data.productName ?? '',
                                  quantity: data.quantity ?? 0,
                                  sellingPrice: data.sellingPrice ?? 0,
                                ),
                              ),
                            );

                            if (item != null) {
                              widget.itemsNotifier.value = [
                                ...widget.itemsNotifier.value,
                                item
                              ];
                              widget.addItem(item);
                            }
                          },
                          child: Container(
                            width: MediaQuery.sizeOf(context).width,
                            padding: const EdgeInsets.symmetric(
                                vertical: 7, horizontal: 15),
                            decoration: BoxDecoration(
                              color: colorScheme.cardColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.productName ?? '',
                                  style: context.textTheme.s15w400.copyWith(
                                    color: colorScheme.colorScheme.onSurface,
                                  ),
                                ),
                                const VerticalSpacing(5),
                                Text(
                                  data.description ?? '',
                                  style: context.textTheme.s12w400.copyWith(
                                    color: colorScheme.colorScheme.onSurface,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const VerticalSpacing(15)
                      ],
                    );
                  },
                ),
        )),
      ),
    );
  }
}
