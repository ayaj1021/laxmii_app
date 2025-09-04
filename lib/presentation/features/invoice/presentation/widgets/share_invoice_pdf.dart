import 'dart:io';

import 'package:intl/intl.dart';
import 'package:laxmii_app/core/utils/utils.dart';
import 'package:laxmii_app/presentation/features/invoice/data/model/create_invoice_request.dart';
import 'package:laxmii_app/presentation/features/invoice/data/model/get_all_invoice_response.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

class InvoicePdfGenerator {
  Future<void> generateAndSharePDF({
    List<String>? cells,
    bool isHeader = false,
    String? title,
    required double total,
    required double filteredInvoiceTotal,
    required String customerName,
    required String dueDate,
    required String currency,
    required String invoiceNumber,
    required List<CreateInvoiceItem> invoiceItems,
    required List<Item> filteredInvoices,
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
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.Text(
                    customerName,
                    style: pw.TextStyle(
                      fontSize: 24, // Match font size
                      fontWeight: pw.FontWeight.bold, // Match font weight
                    ),
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Row(
                        children: [
                          pw.Text(
                            'Invoices:',
                            style: pw.TextStyle(
                              fontSize: 14, // Match font size
                              fontWeight:
                                  pw.FontWeight.normal, // Match font weight
                            ),
                          ),
                          pw.SizedBox(width: 5),
                          pw.Text(
                            invoiceNumber,
                            style: pw.TextStyle(
                              fontSize: 13, // Match font size
                              fontWeight:
                                  pw.FontWeight.bold, // Match font weight
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 6),
                      pw.Row(
                        children: [
                          pw.Text(
                            'Due:',
                            style: pw.TextStyle(
                              fontSize: 14, // Match font size
                              fontWeight:
                                  pw.FontWeight.normal, // Match font weight
                            ),
                          ),
                          pw.SizedBox(width: 3),
                          pw.Text(
                            AppDateFormatter.formatAppDate(dueDate),
                            style: pw.TextStyle(
                              fontSize: 15, // Match font size
                              fontWeight:
                                  pw.FontWeight.bold, // Match font weight
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Table(
                border: pw.TableBorder.all(), // Add border to the table
                columnWidths: {
                  0: const pw.FlexColumnWidth(
                      1), // Adjust column widths to match the first table
                  1: const pw.FlexColumnWidth(2),
                  2: const pw.FlexColumnWidth(2),
                  3: const pw.FlexColumnWidth(1),
                },
                children: [
                  pw.TableRow(
                    children: cells!.map((cell) {
                      return pw.Padding(
                        padding: const pw.EdgeInsets.all(
                            8), // Match padding with the first table
                        child: pw.Text(
                          cell,
                          style: pw.TextStyle(
                            fontSize: 12, // Match font size
                            fontWeight: pw.FontWeight.bold, // Match font weight
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
              invoiceItems.isEmpty
                  ? pw.Column(
                      children: List.generate(filteredInvoices.length, (index) {
                        final reportData = filteredInvoices[index];
                        final total =
                            '${(reportData.quantity == 0 ? 1 : reportData.quantity) * reportData.price}';
                        final rowData = [
                          (reportData.description ?? ''),
                          //  '${reportData.quantity }',
                          '${reportData.quantity == 0 ? '' : reportData.quantity}',
                          '${reportData.price}',
                          ' ${num.parse(total).toStringAsFixed(2)}',
                          // '${(reportData.quantity) * (reportData.price)}',
                        ];

                        return pw.Table(
                          border: pw.TableBorder.all(),
                          columnWidths: {
                            0: const pw.FlexColumnWidth(
                                1), // Adjust column widths as needed
                            1: const pw.FlexColumnWidth(2),
                            2: const pw.FlexColumnWidth(2),
                            3: const pw.FlexColumnWidth(1),
                          },
                          children: [
                            pw.TableRow(
                              children: rowData.map((data) {
                                return pw.Padding(
                                  padding: const pw.EdgeInsets.all(8),
                                  child: pw.Text(
                                    data,
                                    style: pw.TextStyle(
                                      fontSize: 12,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        );
                      }),
                    )
                  : pw.Column(
                      children: List.generate(invoiceItems.length, (index) {
                        final reportData = invoiceItems[index];
                        final rowData = [
                          (reportData.description),
                          '${reportData.quantity}',
                          '${reportData.price}',
                          '${(reportData.quantity) * (reportData.price)}',
                        ];

                        return pw.Table(
                          border: pw.TableBorder.all(),
                          columnWidths: {
                            0: const pw.FlexColumnWidth(
                                1), // Adjust column widths as needed
                            1: const pw.FlexColumnWidth(2),
                            2: const pw.FlexColumnWidth(2),
                            3: const pw.FlexColumnWidth(1),
                          },
                          children: [
                            pw.TableRow(
                              children: rowData.map((data) {
                                return pw.Padding(
                                  padding: const pw.EdgeInsets.all(8),
                                  child: pw.Text(
                                    data,
                                    style: pw.TextStyle(
                                      fontSize: 12,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        );
                      }),
                    ),
              pw.SizedBox(height: 20),
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(horizontal: 16),
                child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('Total ($currency)'),
                      pw.Text(
                        '$currency${total.toStringAsFixed(2).toString()}',
                      )
                    ]),
              ),
              pw.SizedBox(height: 50),
            ],
          );
        },
      ),
    );

    // Save PDF
    final output = await getTemporaryDirectory();
    final file = File('${output.path}/Report.pdf');
    await file.writeAsBytes(await pdf.save());

    // Share PDF
    await Share.shareXFiles(
      [XFile(file.path)],
      text: 'Report',
      subject: 'Report PDF',
    );
  }

  static String formatAppDate(String date) {
    DateTime parsedDate;

    try {
      parsedDate = DateTime.parse(date); // Try ISO format
    } catch (_) {
      parsedDate = DateFormat('MMMM d, yyyy').parse(date); // Try custom format
    }

    return DateFormat('d MMM, yy').format(parsedDate);
  }
}
