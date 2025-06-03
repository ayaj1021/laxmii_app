import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/data/local_data_source/local_storage_impl.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/activity/data/model/get_graph_details_response.dart';
import 'package:laxmii_app/presentation/features/transactions/presentation/widgets/transactions_widget.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class ExpenseDetailsWidget extends StatefulWidget {
  const ExpenseDetailsWidget(
      {super.key, required this.expenseDetails, required this.currency});
  final List<Expense> expenseDetails;
  final String currency;

  @override
  State<ExpenseDetailsWidget> createState() => _ExpenseDetailsWidgetState();
}

class _ExpenseDetailsWidgetState extends State<ExpenseDetailsWidget> {
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
      itemCount: widget.expenseDetails.length,
      itemBuilder: (context, index) {
        final data = widget.expenseDetails[index];
        String inputDate = "${data.createdAt}";
        DateTime parsedDate = DateTime.parse(inputDate);
        String formattedDate = DateFormat("MMM d yyyy").format(parsedDate);
        return Column(
          children: [
            TransactionsWidget(
              expenseName: data.expenseType ?? '',
              expenseType: 'Expense | ${data.supplierName}',
              expenseAmount:
                  '$userCurrency${data.amount?.toStringAsFixed(2) ?? ''}',
              expenseDate: formattedDate,
              amountColor: AppColors.red,
            ),
            const VerticalSpacing(10)
          ],
        );
      },
    ));
  }
}
