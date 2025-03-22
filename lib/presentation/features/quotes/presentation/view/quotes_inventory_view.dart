import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/utils/date_format.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/inventory/presentation/notifier/get_all_inventory_notifier.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/get_access_token_notifier.dart';
import 'package:laxmii_app/presentation/features/quotes/data/model/create_quotes_request.dart';
import 'package:laxmii_app/presentation/features/quotes/presentation/widgets/add_item_section.dart';
import 'package:laxmii_app/presentation/features/quotes/presentation/widgets/get_quotes_widget.dart';
import 'package:laxmii_app/presentation/general_widgets/laxmii_app_bar.dart';
import 'package:laxmii_app/presentation/general_widgets/page_loader.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class QuoteInventoryListView extends ConsumerStatefulWidget {
  const QuoteInventoryListView({
    super.key,
    required this.addItem,
    required this.itemsNotifier,
  });
  final Function(ProductItem newItem) addItem;
  final ValueNotifier<List<ProductItem>> itemsNotifier;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AllInventoryListViewState();
}

class _AllInventoryListViewState extends ConsumerState<QuoteInventoryListView> {
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
          child: ListView.builder(
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
                          builder: (_) => AddItemSection(
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
                    child: GetQuotesWidget(
                        quoteAmount: '\$${data.sellingPrice}',
                        quoteTitle: '${data.productName}',
                        quoteDate: formatDateTimeFromString('${data.createdAt}')

                        // '${data.createdAt}',
                        ),
                  ),
                  const VerticalSpacing(15),
                ],
              );

              // ListTile(
              //   onTap: () async {
              //     final item = await Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (_) => AddItemSection(
              //           //  addItem: widget.addItem(data),
              //           item: data.productName ?? '',
              //           quantity: data.quantity ?? 0,
              //           sellingPrice: data.sellingPrice ?? 0,
              //         ),
              //       ),
              //     );

              //     //context.pushNamed(AddNewInvoiceView.routeName);
              //     if (item != null) {
              //       widget.itemsNotifier.value = [
              //         ...widget.itemsNotifier.value,
              //         item
              //       ];
              //       widget.addItem(item);
              //     }
              //   },
              //   title: Text(
              //     data.productName ?? '',
              //     style: context.textTheme.s12w400.copyWith(
              //       color: AppColors.white,
              //     ),
              //   ),
              //   subtitle: Text(
              //     data.description ?? '',
              //     style: context.textTheme.s12w400.copyWith(
              //       color: AppColors.white,
              //     ),
              //   ),
              // );
            },
          ),
        )),
      ),
    );
  }
}
