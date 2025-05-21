import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:laxmii_app/core/extensions/build_context_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/data/local_data_source/local_storage_impl.dart';
import 'package:laxmii_app/presentation/features/dashboard/dashboard.dart';
import 'package:laxmii_app/presentation/features/quotes/data/model/create_quotes_request.dart';
import 'package:laxmii_app/presentation/features/quotes/presentation/widgets/quote_generator_class.dart';
import 'package:laxmii_app/presentation/general_widgets/laxmii_app_bar.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class QuotePage extends StatefulWidget {
  const QuotePage(
      {super.key,
      required this.clientName,
      required this.quoteNo,
      required this.issueDate,
      required this.dueDate,
      required this.items,
      required this.businessName,
      required this.businessAddress});
  final String clientName;
  final String quoteNo;
  final String issueDate;
  final String dueDate;
  final String businessName;
  final String businessAddress;

  final List<ProductItem> items;

  @override
  State<QuotePage> createState() => _QuotePageState();
}

class _QuotePageState extends State<QuotePage> {
  @override
  void initState() {
    getUserCurrency();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      calculateTotalAmount();
    });
    getAddress();
    super.initState();
  }

  String userCurrency = '\$';

  void getUserCurrency() async {
    final currency = await AppDataStorage().getUserCurrency();

    setState(() {
      userCurrency = currency ?? '\$';
    });
  }

  double totalAmount = 0.0;
  calculateTotalAmount() {
    setState(() {
      totalAmount = widget.items.fold(0.0,
          (double sum, item) => sum + (item.itemPrice * item.itemQuantity));
    });
  }

  String address = '';
  String businessName = '';

  getAddress() async {
    final profileResponse = await AppDataStorage().getStoredProfile();
    setState(() {
      address = profileResponse?.profile?.address ?? '';
      businessName = profileResponse?.profile?.businessName ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LaxmiiAppBar(
        title: 'Quote',
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            padding: const EdgeInsets.only(right: 12),
            onPressed: () => QuoteGenerator().generateAndSharePDF(
              clientName: widget.clientName,
              invoiceNo: widget.quoteNo,
              issueDate: widget.issueDate,
              dueDate: widget.dueDate,
              items: widget.items,
              totalAmount: '$totalAmount',
              address: address,
              businessName: businessName,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with logo and company details
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'QUOTE',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Company Name: ${widget.businessName}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Address: ${widget.businessAddress}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Client details
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('FOR'),
                Text(
                  widget.clientName,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                // const Text('11 Beach Dr'),
                // const Text('Ellington'),
                // const Text('NE51 5EU'),
                // const Text('United Kingdom'),
              ],
            ),

            const SizedBox(height: 20),

            // Quote details
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quote No.:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Issue date:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Valid until:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      widget.quoteNo,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.issueDate,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.dueDate,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Table
            Container(
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              child: Table(
                border: TableBorder.all(),
                columnWidths: const {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(1),
                  2: FlexColumnWidth(1),
                  3: FlexColumnWidth(1),
                },
                children: [
                  const TableRow(
                    children: [
                      TableCell(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('DESCRIPTION'),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('QUANTITY'),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('UNIT PRICE'),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('AMOUNT'),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                                List.generate(widget.items.length, (index) {
                              final item = widget.items[index];
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.itemName),
                                  const VerticalSpacing(8)
                                ],
                              );
                            }),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                                List.generate(widget.items.length, (index) {
                              final item = widget.items[index];
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        log(item.itemQuantity.toString());
                                      },
                                      child:
                                          Text(item.itemQuantity.toString())),
                                  const VerticalSpacing(8)
                                ],
                              );
                            }),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                                List.generate(widget.items.length, (index) {
                              final item = widget.items[index];
                              return Column(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.itemPrice.toString()),
                                  const VerticalSpacing(8)
                                ],
                              );
                            }),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                                List.generate(widget.items.length, (index) {
                              final item = widget.items[index];
                              final total = item.itemQuantity * item.itemPrice;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(total.toString()),
                                  const VerticalSpacing(8)
                                ],
                              );
                            }),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Totals
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //   Text('SUBTOTAL:'),
                    Text('TOTAL:'),
                  ],
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    //  Text('\$$totalAmount'),
                    Text('$userCurrency$totalAmount'),
                  ],
                ),
              ],
            ),

            const VerticalSpacing(50),
            GestureDetector(
              onTap: () => context.pushReplacementNamed(Dashboard.routeName),
              child: const Center(
                child: Text(
                  'Go back home',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
