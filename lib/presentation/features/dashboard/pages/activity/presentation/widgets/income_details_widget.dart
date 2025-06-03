import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/data/local_data_source/local_storage_impl.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/activity/data/model/get_graph_details_response.dart';
import 'package:laxmii_app/presentation/features/transactions/presentation/widgets/transactions_widget.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class IncomeDetailsWidget extends StatefulWidget {
  const IncomeDetailsWidget(
      {super.key, required this.incomeDetails, required this.currency});
  final List<Income> incomeDetails;
  final String currency;

  @override
  State<IncomeDetailsWidget> createState() => _IncomeDetailsWidgetState();
}

class _IncomeDetailsWidgetState extends State<IncomeDetailsWidget> {
  @override
  void initState() {
    getUserCurrency();
    super.initState();
  }

  String userCurrency = '\$';

  void getUserCurrency() async {
    final currency = await AppDataStorage().getUserCurrency();

    setState(() {
      userCurrency = currency ?? '\$';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
      itemCount: widget.incomeDetails.length,
      itemBuilder: (context, index) {
        final data = widget.incomeDetails[index];
        String inputDate = "${data.createdAt}";
        DateTime parsedDate = DateTime.parse(inputDate);
        String formattedDate = DateFormat("MMM d yyyy").format(parsedDate);
        return Column(
          children: [
            TransactionsWidget(
              expenseName: data.inventory ?? '',
              expenseType: 'Income | ${data.customerName ?? ''}',
              expenseAmount:
                  '$userCurrency${data.amount?.toStringAsFixed(2) ?? ''}',
              expenseDate: formattedDate,
              amountColor: AppColors.primary198624,
            ),
            const VerticalSpacing(10)
          ],
        );
      },
    ));
  }
}
