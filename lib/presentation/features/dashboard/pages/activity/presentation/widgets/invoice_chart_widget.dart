import 'package:flutter/material.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/features/invoice/data/model/get_all_invoice_response.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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

    final colorScheme = Theme.of(context);
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.2,
          child: SfCircularChart(
            series: <DoughnutSeries<_ChartData, String>>[
              DoughnutSeries<_ChartData, String>(
                dataSource: [
                  _ChartData(
                      'Paid', paidInvoice.toDouble(), AppColors.primary075427),
                  _ChartData('Unpaid', unPaidInvoice.toDouble(),
                      AppColors.primary861919),
                  _ChartData('Overdue', overDueInvoice.toDouble(),
                      AppColors.primaryA67C00),
                ],
                xValueMapper: (datum, _) => datum.label,
                yValueMapper: (datum, _) => datum.value,
                pointColorMapper: (datum, _) => datum.color,
                startAngle: 360, // Creates the semi-doughnut effect
                endAngle: 360,
                innerRadius: '70%', // Controls the thickness of the doughnut
              )
            ],
          ),
        ),
        //   const VerticalSpacing(15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$invoiceLength',
              style: context.textTheme.s20w700.copyWith(
                fontWeight: FontWeight.w800,
                color: colorScheme.colorScheme.onSurface,
              ),
            ),
            const HorizontalSpacing(5),
            Text(
              'Total Invoices',
              style: context.textTheme.s12w600.copyWith(
                color: AppColors.primary737373,
              ),
            ),
          ],
        ),
        const VerticalSpacing(15),
        const Padding(
          padding: EdgeInsets.only(left: 30),
          child: Row(
            children: [
              InvoiceContainerNameWIdget(
                title: 'Paid',
                color: AppColors.primary075427,
                textColor: AppColors.white,
              ),
              HorizontalSpacing(8),
              InvoiceContainerNameWIdget(
                title: 'Unpaid',
                color: AppColors.primary861919,
                textColor: AppColors.white,
              ),
              HorizontalSpacing(8),
              InvoiceContainerNameWIdget(
                title: 'Overdue',
                color: AppColors.primaryA67C00,
                textColor: AppColors.white,
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _ChartData {
  final String label;
  final double value;
  final Color color;

  _ChartData(this.label, this.value, this.color);
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
