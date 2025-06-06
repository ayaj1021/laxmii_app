import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:laxmii_app/presentation/features/inventory/data/model/get_all_inventory_response.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class InventoryReportImageGenerator {
  final GlobalKey _reportKey = GlobalKey();

  // Method to build the report UI as a Widget with improved styling
  Widget buildReportWidget({
    List<String>? cells,
    String? title,
    required List<Inventory> report,
  }) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              title ?? '',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Header Table
          Table(
            border: TableBorder.all(
              color: Colors.black,
              width: 1,
              style: BorderStyle.solid,
            ),
            columnWidths: const {
              0: FlexColumnWidth(1),
              1: FlexColumnWidth(2),
              2: FlexColumnWidth(2),
              3: FlexColumnWidth(1),
            },
            children: [
              TableRow(
                decoration: const BoxDecoration(
                  color: Color(0xFFEEEEEE),
                ),
                children: cells!.map((cell) {
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      cell,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                        color: Colors.black,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          // Data Rows
          Container(
            constraints: const BoxConstraints(maxHeight: 600),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: report.length,
              itemBuilder: (context, index) {
                final reportData = report[index];
                final rowData = [
                  (reportData.description ?? ''),
                  '${reportData.quantity ?? ''}',
                  '${reportData.costPrice ?? ''}',
                  '${reportData.sellingPrice ?? ''}'
                ];

                return Table(
                  border: TableBorder.all(
                    color: Colors.black,
                    width: 1,
                    style: BorderStyle.solid,
                  ),
                  columnWidths: const {
                    0: FlexColumnWidth(1),
                    1: FlexColumnWidth(2),
                    2: FlexColumnWidth(2),
                    3: FlexColumnWidth(1),
                  },
                  children: [
                    TableRow(
                      decoration: BoxDecoration(
                        color: index.isEven
                            ? Colors.white
                            : const Color(0xFFF5F5F5),
                      ),
                      children: rowData.map((data) {
                        return Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            data,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none,
                              color: Colors.black,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Method to generate and share the image with improved rendering
  Future<void> generateAndShareImage({
    List<String>? cells,
    bool isHeader = false,
    String? title,
    required List<Inventory> report,
    required BuildContext context,
  }) async {
    // Calculate report size based on data
    final double reportHeight = 300.0 + (report.length * 40).clamp(0, 600);

    // First render the report to an offscreen widget
    final repaintBoundary = RepaintBoundary(
      key: _reportKey,
      child: Material(
        color: Colors.transparent,
        child: buildReportWidget(
          cells: cells,
          title: title,
          report: report,
        ),
      ),
    );

    // Create a new overlay entry to render our widget offscreen
    final overlayState = Overlay.of(context);
    final entry = OverlayEntry(
      builder: (context) => Positioned(
        left: -10000, // Position offscreen
        child: SizedBox(
          width: 1080, // Fixed width for better quality
          height: reportHeight,
          child: repaintBoundary,
        ),
      ),
    );

    overlayState.insert(entry);

    // Wait for the layout to complete
    await Future.delayed(const Duration(milliseconds: 800));

    try {
      // Capture the image
      final RenderRepaintBoundary boundary = _reportKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      final ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);

      // Remove the overlay entry
      entry.remove();

      if (byteData != null) {
        final Uint8List pngBytes = byteData.buffer.asUint8List();

        // Save image
        final output = await getTemporaryDirectory();
        final file = File('${output.path}/Report.png');
        await file.writeAsBytes(pngBytes);

        // Share image
        await Share.shareXFiles(
          [XFile(file.path)],
          text: 'Report',
          subject: 'Report Image',
        );
      }
    } catch (e) {
      entry.remove();
      log('Error generating image: $e');
      // Show error message to user

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to generate report image')),
      );
    }
  }
}
