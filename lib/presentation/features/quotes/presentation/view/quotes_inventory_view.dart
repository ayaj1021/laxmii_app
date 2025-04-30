import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/extensions/build_context_extension.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/core/utils/date_format.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/data/local_data_source/local_storage_impl.dart';
import 'package:laxmii_app/presentation/features/inventory/presentation/notifier/get_all_inventory_notifier.dart';
import 'package:laxmii_app/presentation/features/inventory/presentation/view/create_inventory_view.dart';
import 'package:laxmii_app/presentation/features/invoice/presentation/widgets/invoice_new_product_widget.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/get_access_token_notifier.dart';
import 'package:laxmii_app/presentation/features/quotes/data/model/create_quotes_request.dart';
import 'package:laxmii_app/presentation/features/quotes/presentation/widgets/add_item_section.dart';
import 'package:laxmii_app/presentation/features/quotes/presentation/widgets/get_quotes_widget.dart';
import 'package:laxmii_app/presentation/general_widgets/empty_page.dart';
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
    getUserCurrency();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(getAccessTokenNotifier.notifier).accessToken();
      await ref
          .read(getAllInventoryNotifierProvider.notifier)
          .getAllInventory();
    });
    super.initState();
  }

  String userCurrency = '\$';

  void getUserCurrency() async {
    final currency = await AppDataStorage().getUserCurrency();

    setState(() {
      userCurrency = currency ?? '\$';
    });
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
      appBar: LaxmiiAppBar(
        title: 'Inventory',
        //centerTitle: true,
        actions: [
          GestureDetector(
              onTap: () => context.pushNamed(CreateInventory.routeName),
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text(
                  'Add inventory',
                  style: context.textTheme.s15w600.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
              ))
        ],
      ),
      body: PageLoader(
        isLoading: isLoading,
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: isLoading
              ? const SizedBox.shrink()
              : inventoryList.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const EmptyPage(
                              emptyMessage:
                                  'Inventory is empty try to create inventory'),
                          const VerticalSpacing(10),
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
                  : Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.5,
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
                                            serviceType: data.type ?? '',
                                            item: data.productName ?? '',
                                            quantity: data.quantity ?? 0,
                                            sellingPrice: data.sellingPrice ??
                                                data.costPrice ??
                                                0,
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
                                      //${data?.sellingPrice ?? data?.costPrice}
                                    },
                                    child: GetQuotesWidget(
                                        quoteAmount:
                                            '$userCurrency${data.sellingPrice ?? data.costPrice}',
                                        quoteTitle: '${data.productName}',
                                        quoteDate: formatDateTimeFromString(
                                            '${data.createdAt}')

                                        // '${data.createdAt}',
                                        ),
                                  ),
                                  const VerticalSpacing(15),
                                ],
                              );
                            },
                          ),
                        ),
                        ValueListenableBuilder(
                            valueListenable: widget.itemsNotifier,
                            builder: (context, items, child) {
                              return items.isEmpty
                                  ? const SizedBox.shrink()
                                  : Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 17),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          color: colorScheme.cardColor),
                                      child: Column(
                                        children: [
                                          ValueListenableBuilder(
                                              valueListenable:
                                                  widget.itemsNotifier,
                                              builder: (context, items, child) {
                                                return SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.23,
                                                  child: ListView.builder(
                                                      physics:
                                                          const AlwaysScrollableScrollPhysics(),
                                                      itemCount: items.length,
                                                      itemBuilder: (_, index) {
                                                        final item =
                                                            items[index];
                                                        final price =
                                                            item.itemQuantity *
                                                                item.itemPrice;
                                                        return Column(
                                                          children: [
                                                            InvoiceNewProductWidget(
                                                              itemName:
                                                                  item.itemName,
                                                              itemQuantity: item
                                                                  .itemQuantity,
                                                              itemPrice: item
                                                                  .itemPrice,
                                                              totalItemPrice:
                                                                  double.parse(price
                                                                      .toStringAsFixed(
                                                                          2)),
                                                              onItemDelete: () {
                                                                setState(() {
                                                                  items.remove(
                                                                      item);
                                                                });
                                                                //    removeItem(item);
                                                              },
                                                            ),
                                                            const VerticalSpacing(
                                                                5),
                                                            if (index <
                                                                items.length -
                                                                    1)
                                                              const Divider(
                                                                color: AppColors
                                                                    .primary3B3522,
                                                              )
                                                          ],
                                                        );
                                                      }),
                                                );
                                              }),
                                          InkWell(
                                            onTap: () async {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'Done',
                                              style: context.textTheme.s14w500
                                                  .copyWith(
                                                color: AppColors.primaryColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                            }),
                      ],
                    ),
        )),
      ),
    );
  }
}
