import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:laxmii_app/core/extensions/overlay_extension.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/features/invoice/presentation/view/invoice_details_view.dart';
import 'package:laxmii_app/presentation/features/invoice/presentation/widgets/invoice_widget.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/get_access_token_notifier.dart';
import 'package:laxmii_app/presentation/general_widgets/app_button.dart';
import 'package:laxmii_app/presentation/general_widgets/laxmii_app_bar.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class CreateInvoiceOneView extends ConsumerStatefulWidget {
  const CreateInvoiceOneView({super.key});
  static const routeName = '/createInvoiceView';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddSalesViewState();
}

class _AddSalesViewState extends ConsumerState<CreateInvoiceOneView> {
  final ValueNotifier<bool> _isAddSalesEnabled = ValueNotifier(false);
  late TextEditingController _amountController;
  late TextEditingController _customerNameController;
  late TextEditingController _invoiceNumberController;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(getAccessTokenNotifier.notifier).accessToken();
    });
    _amountController = TextEditingController()..addListener(_validateInput);
    _invoiceNumberController = TextEditingController()
      ..addListener(_validateInput);
    _customerNameController = TextEditingController()
      ..addListener(_validateInput);
    super.initState();
  }

  void _validateInput() {
    _isAddSalesEnabled.value = _invoiceNumberController.text.isNotEmpty &&
        _customerNameController.text.isNotEmpty;
  }

  @override
  void dispose() {
    _amountController.dispose();
    _customerNameController.dispose();
    _invoiceNumberController.dispose();
    super.dispose();
  }

  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    //  DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      //firstDate: DateTime(now.year, now.month, now.day),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  String _formatDate(DateTime date) {
    return DateFormat('MMM d, yyyy').format(date);
  }

  DateTime? _selectedDueDate;

  Future<void> _selectDueDate(BuildContext context) async {
    //  DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDueDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      //  firstDate: DateTime(now.year, now.month, now.day),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _selectedDueDate) {
      setState(() {
        _selectedDueDate = picked;
      });
    }
  }

  String _formatDueDate(DateTime date) {
    return DateFormat('MMM d, yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LaxmiiAppBar(
        title: 'New invoice',
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          //  crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Step 1 of 2',
              style: context.textTheme.s12w500.copyWith(
                color: AppColors.white,
              ),
            ),
            const VerticalSpacing(10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 17),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.primary101010),
              child: Column(
                children: [
                  TextField(
                    style: context.textTheme.s14w400.copyWith(
                      color: AppColors.white,
                    ),
                    controller: _customerNameController,
                    decoration: InputDecoration(
                      hintText: 'Customer (required)',
                      hintStyle: context.textTheme.s14w400.copyWith(
                        color: AppColors.primary5E5E5E.withOpacity(0.5),
                      ),
                      border: InputBorder.none,
                      fillColor: Colors.transparent,
                      filled: false,
                      focusColor: Colors.transparent,
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    color: AppColors.primary3B3522,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: [
                        Text(
                          'Invoice no.',
                          style: context.textTheme.s14w400.copyWith(
                            color: AppColors.primary5E5E5E,
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: TextField(
                            style: context.textTheme.s14w400.copyWith(
                              color: AppColors.white,
                            ),
                            keyboardType: TextInputType.number,
                            controller: _invoiceNumberController,
                            decoration: InputDecoration(
                              hintText: 'Enter or let us assign',
                              border: InputBorder.none,
                              hintStyle: context.textTheme.s14w400.copyWith(
                                color: AppColors.primary5E5E5E.withOpacity(0.5),
                              ),
                              fillColor: Colors.transparent,
                              filled: false,
                              focusColor: Colors.transparent,
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: AppColors.primary3B3522,
                  ),
                  const VerticalSpacing(10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: [
                        Text(
                          'Date',
                          style: context.textTheme.s14w400.copyWith(
                            color: AppColors.primary5E5E5E,
                          ),
                        ),
                        const HorizontalSpacing(50),
                        GestureDetector(
                          onTap: () => _selectDate(context),
                          child: Text(
                            _selectedDate == null
                                ? 'Select Date'
                                : _formatDate(_selectedDate!),
                            style: context.textTheme.s12w400.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const VerticalSpacing(10),
                  const Divider(
                    color: AppColors.primary3B3522,
                  ),
                  const VerticalSpacing(10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: [
                        Text(
                          'Due on',
                          style: context.textTheme.s14w400.copyWith(
                            color: AppColors.primary5E5E5E,
                          ),
                        ),
                        const HorizontalSpacing(35),
                        GestureDetector(
                          onTap: () => _selectDueDate(context),
                          child: Text(
                            _selectedDueDate == null
                                ? 'Select Date'
                                : _formatDueDate(_selectedDueDate!),
                            style: context.textTheme.s12w400.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const VerticalSpacing(16),
            Container(
              padding: const EdgeInsets.only(
                top: 200,
                bottom: 15,
                left: 108,
                right: 90,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.primary101010),
              child: Row(
                children: [
                  const Icon(
                    Icons.add_circle,
                    color: AppColors.primaryColor,
                  ),
                  const HorizontalSpacing(5),
                  Text(
                    'Add product or service',
                    style: context.textTheme.s14w500.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  )
                ],
              ),
            ),
            const VerticalSpacing(24),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16)),
                  color: AppColors.primary101010),
              child: Column(
                children: [
                  const InvoiceWidget(
                    title: 'Subtotal',
                    subTitle: '\$0.00',
                  ),
                  const VerticalSpacing(14),
                  const InvoiceWidget(
                    title: 'Tax 8%',
                    subTitle: '\$0.00',
                  ),
                  const VerticalSpacing(14),
                  const InvoiceWidget(
                    title: 'Balance due',
                    subTitle: '\$0.00',
                  ),
                  const VerticalSpacing(19),
                  ValueListenableBuilder(
                      valueListenable: _isAddSalesEnabled,
                      builder: (context, r, c) {
                        return LaxmiiSendButton(
                            isEnabled: r,
                            textColor: AppColors.black,
                            onTap: () {
                              if (_selectedDate == null ||
                                  _selectedDueDate == null) {
                                context.showError(
                                    message: 'Dates cannot be empty');
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => InvoiceDetailsView(
                                              customerName:
                                                  _customerNameController.text
                                                      .trim(),
                                              issueDate:
                                                  _formatDate(_selectedDate!),
                                              dueDate: _formatDueDate(
                                                  _selectedDueDate!),
                                              invoiceNumber:
                                                  _invoiceNumberController.text
                                                      .trim(),
                                            )));
                              }
                            },
                            title: 'Continue');
                      }),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
