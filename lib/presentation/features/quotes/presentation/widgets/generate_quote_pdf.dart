import 'package:flutter/material.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/features/quotes/data/model/create_quotes_request.dart';
import 'package:laxmii_app/presentation/general_widgets/laxmii_app_bar.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';

class QuotePage extends StatefulWidget {
  const QuotePage(
      {super.key,
      required this.clientName,
      required this.quoteNo,
      required this.issueDate,
      required this.dueDate,
      required this.items});
  final String clientName;
  final String quoteNo;
  final String issueDate;
  final String dueDate;
  final List<ProductItem> items;

  @override
  State<QuotePage> createState() => _QuotePageState();
}

class _QuotePageState extends State<QuotePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      calculateTotalAmount();
    });
    super.initState();
  }

  double totalAmount = 0.0;
  calculateTotalAmount() {
    setState(() {
      totalAmount =
          widget.items.fold(0.0, (double sum, item) => sum + item.itemPrice);
    });
    // totalAmount =
    //     widget.items.fold(0.0, (double sum, item) => sum + item.itemPrice);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: LaxmiiAppBar(
        title: 'Quote',
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            padding: const EdgeInsets.only(right: 12),
            onPressed: () => QuoteGenerator().generateAndSharePDF(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with logo and company details
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'QUOTE',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.end,
                //   children: [
                //     Text('Ellington Wood Decor'),
                //     Text('36 Terrick Rd, Ellington PE18 2NT, United Kingdom'),
                //   ],
                // ),
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
                                  Text(item.itemQuantity.toString()),
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
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.itemPrice.toString()),
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
                    Text('SUBTOTAL:'),
                    Text('TOTAL (GBP):'),
                  ],
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('\$$totalAmount'),
                    Text('\$$totalAmount'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class QuoteGenerator {
  Future<void> generateAndSharePDF() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'QUOTE',
                    style: pw.TextStyle(
                      fontSize: 24,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text('Ellington Wood Decor'),
                      pw.Text(
                          '36 Terrick Rd, Ellington PE18 2NT, United Kingdom'),
                    ],
                  ),
                ],
              ),

              pw.SizedBox(height: 20),

              // Client details
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('FOR'),
                  pw.Text('Your client'),
                  pw.Text('11 Beach Dr'),
                  pw.Text('Ellington'),
                  pw.Text('NE51 5EU'),
                  pw.Text('United Kingdom'),
                ],
              ),

              pw.SizedBox(height: 20),

              // Quote details
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('Quote No.:'),
                      pw.Text('Issue date:'),
                      pw.Text('Valid until:'),
                    ],
                  ),
                  pw.SizedBox(width: 20),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text('042023'),
                      pw.Text('24/05/2023'),
                      pw.Text('07/06/2023'),
                    ],
                  ),
                ],
              ),

              pw.SizedBox(height: 20),

              // Table
              pw.Table(
                border: pw.TableBorder.all(),
                columnWidths: {
                  0: const pw.FlexColumnWidth(2),
                  1: const pw.FlexColumnWidth(1),
                  2: const pw.FlexColumnWidth(1),
                  3: const pw.FlexColumnWidth(1),
                },
                children: [
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text('DESCRIPTION'),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text('QUANTITY'),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text('UNIT PRICE (£)'),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text('AMOUNT (£)'),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text('Sample service'),
                            pw.Text('Sample wood decoration service'),
                          ],
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text('1'),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text('400.00'),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text('400.00'),
                      ),
                    ],
                  ),
                ],
              ),

              pw.SizedBox(height: 20),

              // Totals
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('SUBTOTAL:'),
                      pw.Text('TOTAL (GBP):'),
                    ],
                  ),
                  pw.SizedBox(width: 20),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text('£600.00'),
                      pw.Text('£600.00'),
                    ],
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );

    // Save PDF
    final output = await getTemporaryDirectory();
    final file = File('${output.path}/quote.pdf');
    await file.writeAsBytes(await pdf.save());

    // Share PDF
    await Share.shareXFiles(
      [XFile(file.path)],
      text: 'Quote',
      subject: 'Quote PDF',
    );
  }
}
