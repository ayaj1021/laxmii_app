import 'dart:io';

import 'package:laxmii_app/presentation/features/quotes/data/model/create_quotes_request.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

class QuoteGenerator {
  Future<void> generateAndSharePDF({
    required String clientName,
    required String invoiceNo,
    required String issueDate,
    required String dueDate,
    required String totalAmount,
    required String address,
    required String businessName,
    required String currency,
    required List<ProductItem> items,
  }) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
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
                      pw.Text(businessName),
                      pw.Text(address),
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
                  pw.Text(clientName),
                  // pw.Text('11 Beach Dr'),
                  // pw.Text('Ellington'),
                  // pw.Text('NE51 5EU'),
                  // pw.Text('United Kingdom'),
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
                      pw.Text(invoiceNo),
                      pw.Text(issueDate),
                      pw.Text(dueDate),
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
                        child: pw.Text('UNIT PRICE'),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text('AMOUNT'),
                      ),
                    ],
                  ),
                  pw.TableRow(children: [
                    pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: List.generate(items.length, (index) {
                            final item = items[index];
                            return pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(item.itemName),
                                pw.SizedBox(height: 8)
                              ],
                            );
                          }),
                        )),
                    pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: List.generate(items.length, (index) {
                            final item = items[index];
                            return pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(item.itemQuantity.toString()),
                                pw.SizedBox(height: 8)
                              ],
                            );
                          }),
                        )),
                    pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: List.generate(items.length, (index) {
                            final item = items[index];
                            return pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(item.itemPrice.toString()),
                                pw.SizedBox(height: 8)
                              ],
                            );
                          }),
                        )),
                    pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: List.generate(items.length, (index) {
                            final item = items[index];
                            final total = item.itemQuantity * item.itemPrice;
                            return pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(total.toString()),
                                pw.SizedBox(height: 8)
                              ],
                            );
                          }),
                        ))
                  ]

                      // [
                      //   pw.Padding(
                      //     padding: const pw.EdgeInsets.all(8),
                      //     child: pw.Column(
                      //       crossAxisAlignment: pw.CrossAxisAlignment.start,
                      //       children: [
                      //         pw.Text('Sample service'),
                      //         pw.Text('Sample wood decoration service'),
                      //       ],
                      //     ),
                      //   ),
                      //   pw.Padding(
                      //     padding: const pw.EdgeInsets.all(8),
                      //     child: pw.Text('1'),
                      //   ),
                      //   pw.Padding(
                      //     padding: const pw.EdgeInsets.all(8),
                      //     child: pw.Text('400.00'),
                      //   ),
                      //   pw.Padding(
                      //     padding: const pw.EdgeInsets.all(8),
                      //     child: pw.Text('400.00'),
                      //   ),
                      // ],
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
                      //  pw.Text('SUBTOTAL:'),
                      pw.Text('TOTAL:'),
                    ],
                  ),
                  pw.SizedBox(width: 20),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      // pw.Text('£600.00'),
                      pw.Text('$currency$totalAmount'),
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
