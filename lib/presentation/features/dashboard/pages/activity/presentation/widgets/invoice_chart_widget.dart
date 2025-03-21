import 'package:flutter/material.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/activity/presentation/widgets/circle_widget.dart';
import 'package:laxmii_app/presentation/features/invoice/data/model/get_all_invoice_response.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class InvoiceChartWidget extends StatefulWidget {
  const InvoiceChartWidget({super.key, required this.allInvoices});
  final List<GetAllInvoiceData>? allInvoices;

  @override
  State<InvoiceChartWidget> createState() => _InvoiceChartWidgetState();
}

class _InvoiceChartWidgetState extends State<InvoiceChartWidget> {
  @override
  Widget build(BuildContext context) {
    final invoiceLength = widget.allInvoices?.length ?? 0;
    final paidInvoice =
        widget.allInvoices?.where((test) => test.status == 'paid').length ?? 0;
    final unPaidInvoice =
        widget.allInvoices?.where((test) => test.status == 'unpaid').length ??
            0;

    final overDueInvoice =
        widget.allInvoices?.where((test) => test.status == 'overdue').length ??
            0;
    return Column(
      children: [
        // ElevatedButton(
        //     onPressed: () {
        //       log(paidInvoice.toString());
        //     },
        //     child: Text('data')),
        Stack(
          children: [
            SegmentedCircle(
              //  gapAngle: 0.4,
              segments: [
                CircleSegment(
                  color: AppColors.primary062613,
                  value: paidInvoice.toDouble(),
                ),
                CircleSegment(
                  color: AppColors.primary3B0D0D,
                  value: unPaidInvoice.toDouble(),
                ),
                CircleSegment(
                  color: AppColors.primary493703,
                  value: overDueInvoice.toDouble(),
                ),
              ],
              size: paidInvoice.toDouble() * 20,
            ),
            Positioned(
              bottom: 60,
              top: 50,
              right: 65,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$invoiceLength',
                    style: context.textTheme.s20w700.copyWith(
                      fontWeight: FontWeight.w800,
                      color: AppColors.primaryC4C4C4,
                    ),
                  ),
                  Text(
                    'Total Invoices',
                    style: context.textTheme.s12w600.copyWith(
                      color: AppColors.primary737373,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        const VerticalSpacing(15),
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Row(
            children: [
              InvoiceContainerNameWIdget(
                title: 'Paid',
                color: AppColors.primary075427.withValues(alpha: 0.7),
                textColor: AppColors.primaryCFFEE8,
              ),
              const HorizontalSpacing(8),
              InvoiceContainerNameWIdget(
                title: 'Unpaid',
                color: AppColors.primary861919.withValues(alpha: 0.7),
                textColor: AppColors.primaryB17F7F,
              ),
              const HorizontalSpacing(8),
              InvoiceContainerNameWIdget(
                title: 'Overdue',
                color: AppColors.primaryA67C00.withValues(alpha: 0.7),
                textColor: AppColors.primaryB17F7F,
              ),
            ],
          ),
        )
      ],
    );
  }
}

class InvoiceContainerNameWIdget extends StatelessWidget {
  const InvoiceContainerNameWIdget(
      {super.key,
      required this.color,
      required this.title,
      required this.textColor});
  final Color color;
  final Color textColor;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        title,
        style: context.textTheme.s14w400.copyWith(
          color: textColor,
        ),
      ),
    );
  }
}
