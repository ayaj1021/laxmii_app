// ignore_for_file: prefer_is_empty

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laxmii_app/core/extensions/build_context_extension.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/data/local_data_source/local_storage_impl.dart';
import 'package:laxmii_app/presentation/features/inventory/presentation/notifier/get_all_inventory_notifier.dart';
import 'package:laxmii_app/presentation/features/inventory/presentation/view/create_inventory_view.dart';
import 'package:laxmii_app/presentation/features/inventory/presentation/view/update_inventory.dart';
import 'package:laxmii_app/presentation/features/inventory/presentation/widgets/product_services_widget.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/get_access_token_notifier.dart';
import 'package:laxmii_app/presentation/general_widgets/laxmii_app_bar.dart';
import 'package:laxmii_app/presentation/general_widgets/page_loader.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class InventoryView extends ConsumerStatefulWidget {
  const InventoryView({super.key});
  static const routeName = '/inventory';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InventoryState();
}

class _InventoryState extends ConsumerState<InventoryView> {
  @override
  void initState() {
    getUserCurrency();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref
          .read(getAllInventoryNotifierProvider.notifier)
          .getAllInventory();

      await ref.read(getAccessTokenNotifier.notifier).accessToken();
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
    final inventoryList = ref.watch(
        getAllInventoryNotifierProvider.select((v) => v.getAllInventory));
    final isLoading = ref.watch(
        getAllInventoryNotifierProvider.select((v) => v.loadState.isLoading));
    final colorScheme = Theme.of(context);
    return PageLoader(
      isLoading: isLoading,
      child: Scaffold(
        appBar: const LaxmiiAppBar(
          title: 'Product/Services',
          centerTitle: true,
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          child: Column(
            children: [
              GestureDetector(
                onTap: () => context.pushNamed(CreateInventory.routeName),
                child: const Align(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.add_circle,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              const VerticalSpacing(19),
              inventoryList.data?.inventory == null
                  ? const SizedBox.shrink()
                  : inventoryList.data?.inventory?.isEmpty ??
                          inventoryList.data?.inventory?.length == 0
                      ? Column(
                          children: [
                            SvgPicture.asset('assets/icons/empty_data.svg'),
                            const VerticalSpacing(10),
                            Text(
                              'No Inventory Yet',
                              style: context.textTheme.s14w500.copyWith(
                                color: colorScheme.colorScheme.onSurface,
                              ),
                            ),
                          ],
                        )
                      : Expanded(
                          child: ListView.builder(
                              itemCount: inventoryList.data?.inventory?.length,
                              itemBuilder: (_, index) {
                                final data =
                                    inventoryList.data?.inventory?[index];
                                return Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => UpdateInventory(
                                            currency: userCurrency,
                                            serviceType: '${data?.type}',
                                            productName: '${data?.productName}',
                                            productDescription:
                                                '${data?.description}',
                                            sellingPrice:
                                                '${data?.sellingPrice}',
                                            costPrice: '${data?.costPrice}',
                                            itemQuantity: '${data?.quantity}',
                                            itemId: '${data?.id}',
                                          ),
                                        ),
                                      ).then((_) {
                                        ref
                                            .read(
                                                getAllInventoryNotifierProvider
                                                    .notifier)
                                            .getAllInventory();
                                      }),
                                      child: ProductServicesWidget(
                                        itemName: '${data?.productName}',
                                        itemType: '${data?.description}',
                                        itemPrice:
                                            '$userCurrency ${data?.sellingPrice ?? data?.costPrice}',
                                        itemQuantity: data?.quantity == null
                                            ? ''
                                            : '(${data?.quantity})',
                                      ),
                                    ),
                                    const VerticalSpacing(10)
                                  ],
                                );
                              }),
                        )
            ],
          ),
        )),
      ),
    );
  }
}
