import 'dart:io';

import 'package:flutter/material.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

Future<void> shareInvoice({
  required BuildContext context,
  required ScreenshotController screenshotController,
  required String invoiceNumber,
  required String dueDate,
  required String issueDate,
}) async {
  try {
    // Wrap the container in Screenshot widget
    final uint8List = await screenshotController.captureFromWidget(
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.14,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        decoration: const BoxDecoration(
          color: AppColors.primaryC4C4C4,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Invoices',
                  style: context.textTheme.s24w600.copyWith(
                    color: AppColors.black,
                  ),
                ),
                const HorizontalSpacing(5),
                Text(
                  '# $invoiceNumber',
                  style: context.textTheme.s24w600.copyWith(
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
            const VerticalSpacing(9),
            Row(
              children: [
                Text(
                  'Invoice date:',
                  style: context.textTheme.s12w500.copyWith(
                    color: AppColors.black,
                  ),
                ),
                const HorizontalSpacing(3),
                Text(
                  issueDate,
                  style: context.textTheme.s12w500.copyWith(
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
            const VerticalSpacing(10),
            Row(
              children: [
                Text(
                  'Due date:',
                  style: context.textTheme.s12w500.copyWith(
                    color: AppColors.black,
                  ),
                ),
                const HorizontalSpacing(3),
                Text(
                  dueDate,
                  style: context.textTheme.s12w500.copyWith(
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    // Save the screenshot to a temporary file
    final tempDir = await getTemporaryDirectory();
    final file = await File('${tempDir.path}/invoice.png').create();
    await file.writeAsBytes(uint8List);

    // Share the image file
    await Share.shareXFiles(
      [XFile(file.path)],
      text: 'Invoice #$invoiceNumber',
    );
  } catch (e) {
    debugPrint('Error sharing: $e');
  }
}
