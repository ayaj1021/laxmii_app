import 'package:intl/intl.dart';

import 'package:laxmii_app/presentation/features/generate_report/data/model/get_single_report_response.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';

class ReportPdfGenerator {
  Future<void> generateAndSharePDF({
    List<String>? cells,
    bool isHeader = false,
    String? title,
    required List<ReportData> report,
  }) async {
    final pdf = pw.Document();

    String formatDate(date) {
      return DateFormat('d MMM, yy').format(date);
    }

    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Center(
                child: pw.Text(
                  title ?? '',
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
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
              pw.SizedBox(
                height: PdfPageFormat.a4.height * 0.6, // 60% of the page height
                child: pw.ListView(
                  children: List.generate(report.length, (index) {
                    final reportData = report[index];
                    final rowData = [
                      formatDate(reportData.date),
                      '${reportData.expenseType ?? reportData.inventory ?? reportData.invoiceNumber}',
                      '${reportData.supplier ?? reportData.customer ?? reportData.customerName}',
                      '${reportData.amount}'
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
              )
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
}
