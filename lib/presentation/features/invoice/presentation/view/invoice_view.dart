import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:laxmii_app/core/extensions/build_context_extension.dart';
import 'package:laxmii_app/core/extensions/overlay_extension.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/data/local_data_source/local_storage_impl.dart';
import 'package:laxmii_app/presentation/features/invoice/data/model/get_all_invoice_response.dart';
import 'package:laxmii_app/presentation/features/invoice/presentation/notifier/delete_invoice_notifier.dart';
import 'package:laxmii_app/presentation/features/invoice/presentation/notifier/get_all_invoice_notifier.dart';
import 'package:laxmii_app/presentation/features/invoice/presentation/view/confirm_invoice_view.dart';
import 'package:laxmii_app/presentation/features/invoice/presentation/view/create_income_one_view.dart';
import 'package:laxmii_app/presentation/features/invoice/presentation/widgets/invoice_view_widget.dart';
import 'package:laxmii_app/presentation/features/invoice/presentation/widgets/search_bar_widget.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/get_access_token_notifier.dart';
import 'package:laxmii_app/presentation/general_widgets/laxmii_app_bar.dart';
import 'package:laxmii_app/presentation/general_widgets/page_loader.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class InvoiceView extends ConsumerStatefulWidget {
  const InvoiceView({super.key});
  static const routeName = '/invoiceView';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InvoiceViewState();
}

class _InvoiceViewState extends ConsumerState<InvoiceView> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    getUserCurrency();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(getAllInvoiceNotifierProvider.notifier).getAllInvoices();

      if (!mounted) return;
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
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String _selectedOption = 'All';

  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final allInvoiceList = ref.watch(getAllInvoiceNotifierProvider
        .select((v) => v.getAllInvoice.data?.invoices));

    final isLoading = ref.watch(
        getAllInvoiceNotifierProvider.select((v) => v.loadState.isLoading));
    List<GetAllInvoiceData>? filteredInvoices =
        allInvoiceList?.where((invoice) {
      final matchesStatus = _selectedOption == 'All' ||
          invoice.status?.toLowerCase() == _selectedOption.toLowerCase();
      final matchesSearch = _searchQuery.isEmpty ||
          (invoice.customerName?.toLowerCase().contains(_searchQuery) ??
              false) ||
          (invoice.invoiceNumber?.contains(_searchQuery) ?? false);
      return matchesStatus && matchesSearch;
    }).toList();
    final colorScheme = Theme.of(context);
    return Scaffold(
      appBar: const LaxmiiAppBar(
        title: 'Income',
        centerTitle: true,
      ),
      body: PageLoader(
        isLoading: isLoading,
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => context.pushNamed(CreateIncomeOneView.routeName),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Create Income',
                    style: context.textTheme.s15w600.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
              const VerticalSpacing(8),
              Row(
                children: [
                  Expanded(
                      child: SearchBarWidget(
                    searchController: _searchController,
                    onChanged: (String? value) {
                      setState(() {
                        _searchQuery = value!.toLowerCase();
                      });
                    },
                  )),
                  const HorizontalSpacing(16),
                  PopupMenuButton(
                      padding: EdgeInsets.zero,
                      elevation: 0,
                      color: colorScheme.cardColor,
                      onSelected: (value) {
                        setState(() {
                          _selectedOption = value; // Update selected option
                        });
                      },
                      child: Container(
                        height: 40.h,
                        width: 50.w,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color:
                                AppColors.primary5E5E5E.withValues(alpha: 0.5),
                          ),
                        ),
                        child: SvgPicture.asset('assets/icons/filter.svg'),
                      ),
                      itemBuilder: (_) {
                        return [
                          PopupMenuItem(
                            value: 'All',
                            child: Text(
                              'All',
                              style: context.textTheme.s14w400.copyWith(
                                color: AppColors.primary5E5E5E,
                              ),
                            ),
                          ),
                          PopupMenuItem(
                            value: 'Paid',
                            child: Text(
                              'Paid',
                              style: context.textTheme.s14w400.copyWith(
                                color: AppColors.primary5E5E5E,
                              ),
                            ),
                          ),
                          PopupMenuItem(
                            value: 'Unpaid',
                            child: Text(
                              'Unpaid',
                              style: context.textTheme.s14w400.copyWith(
                                color: AppColors.primary5E5E5E,
                              ),
                            ),
                          ),
                          PopupMenuItem(
                            value: 'OverDue',
                            child: Text(
                              'OverDue',
                              style: context.textTheme.s14w400.copyWith(
                                color: AppColors.primary5E5E5E,
                              ),
                            ),
                          ),
                        ];
                      }),
                ],
              ),
              const VerticalSpacing(8),
              Text(
                _selectedOption,
                style: context.textTheme.s12w400.copyWith(
                  color: AppColors.primary5E5E5E,
                ),
              ),
              const VerticalSpacing(10),
              allInvoiceList == null
                  ? const SizedBox.shrink()
                  // ignore: prefer_is_empty
                  : filteredInvoices?.isEmpty ?? filteredInvoices?.length == 0
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset('assets/icons/empty_data.svg'),
                              const VerticalSpacing(10),
                              Text(
                                'Not Available',
                                style: context.textTheme.s14w500.copyWith(
                                  color: colorScheme.colorScheme.onSurface,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: filteredInvoices?.length,
                            itemBuilder: (_, index) {
                              final data = filteredInvoices?[index];
                              String inputDate = "${data?.createdAt}";
                              DateTime parsedDate = DateTime.parse(inputDate);

                              String formattedDate =
                                  DateFormat("MMM d yyyy").format(parsedDate);
                              return Dismissible(
                                key: Key(data?.id ?? ''),
                                direction: DismissDirection.endToStart,
                                background: Container(
                                  color: AppColors.red.withValues(alpha: 0.5),
                                  alignment: Alignment.centerRight,
                                  padding: const EdgeInsets.only(right: 20),
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                                onDismissed: (direction) {
                                  // Remove the item from the list
                                  ref
                                      .read(deleteInvoiceNotifierProvider
                                          .notifier)
                                      .deleteInvoice(
                                    data?.id ?? '',
                                    onSuccess: (message) {
                                      setState(() {
                                        allInvoiceList
                                            .removeAt(index); // local removal
                                      });
                                      ref
                                          .read(getAllInvoiceNotifierProvider
                                              .notifier)
                                          .getAllInvoices();

                                      context.showSuccess(
                                        message: message,
                                      );
                                    },
                                    onError: (message) {
                                      context.showError(
                                        message: message,
                                      );
                                    },
                                  );
                                },
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => ConfirmInvoiceView(
                                          currency: userCurrency,
                                          filteredInvoices: data?.items,
                                          customerName: '${data?.customerName}',
                                          issueDate: '${data?.issueDate}',
                                          dueDate: '${data?.dueDate}',
                                          invoiceNumber:
                                              '${data?.invoiceNumber}',
                                          invoiceId: '${data?.id}',
                                          invoiceStatus: '${data?.status}',
                                        ),
                                      ),
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      InvoiceViewWidget(
                                        invoiceName: data?.customerName ?? '',
                                        invoiceNumber:
                                            data?.invoiceNumber ?? '',
                                        invoiceAmount:
                                            '$userCurrency${data?.totalAmount?.toStringAsFixed(2) ?? ''}',
                                        invoiceStatus: data?.status ?? '',
                                        invoiceDate: formattedDate,
                                        invoiceStatusColor:
                                            data?.status == 'unpaid'
                                                ? AppColors.primary861919
                                                    .withValues(alpha: 0.7)
                                                : data?.status == 'overdue'
                                                    ? AppColors.primaryA67C00
                                                        .withValues(alpha: 0.7)
                                                    : AppColors.primary075427
                                                        .withValues(alpha: 0.7),
                                      ),
                                      const VerticalSpacing(10)
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        )
            ],
          ),
        )),
      ),
    );
  }
}
