import 'package:flutter/widgets.dart';
import 'package:laxmii_app/presentation/features/dashboard/dashboard.dart';
import 'package:laxmii_app/presentation/features/forgot_password/presentation/view/forgot_password.dart';
import 'package:laxmii_app/presentation/features/generate_report/presentation/view/generate_report.dart';
import 'package:laxmii_app/presentation/features/inventory/presentation/view/create_inventory_view.dart';
import 'package:laxmii_app/presentation/features/inventory/presentation/view/inventory_view.dart';
import 'package:laxmii_app/presentation/features/invoice/presentation/view/create_invoice_one_view.dart';
import 'package:laxmii_app/presentation/features/invoice/presentation/view/invoice_view.dart';
import 'package:laxmii_app/presentation/features/login/presentation/login_view.dart';
import 'package:laxmii_app/presentation/features/sign_up/presentation/view/sign_up_view.dart';
import 'package:laxmii_app/presentation/features/todo/presentation/view/create_task_view.dart';
import 'package:laxmii_app/presentation/features/todo/presentation/view/todo_view.dart';
import 'package:laxmii_app/presentation/features/transactions/presentation/view/add_sales_view.dart';
import 'package:laxmii_app/presentation/features/transactions/presentation/view/create_expense_view.dart';
import 'package:laxmii_app/presentation/features/transactions/presentation/view/transactions_view.dart';
import 'package:laxmii_app/presentation/general_widgets/splash_screen.dart';

class AppRouter {
  static final Map<String, Widget Function(BuildContext)> _routes = {
    SplashScreen.routeName: (context) => const SplashScreen(),
    SignUpView.routeName: (context) => const SignUpView(),
    LoginView.routeName: (context) => const LoginView(),
    ForgotPassword.routeName: (context) => const ForgotPassword(),
    Dashboard.routeName: (context) => const Dashboard(),
    InventoryView.routeName: (context) => const InventoryView(),
    CreateInventory.routeName: (context) => const CreateInventory(),
    TransactionsView.routeName: (context) => const TransactionsView(),
    AddSalesView.routeName: (context) => const AddSalesView(),
    CreateExpenseView.routeName: (context) => const CreateExpenseView(),
    InvoiceView.routeName: (context) => const InvoiceView(),
    CreateInvoiceOneView.routeName: (context) => const CreateInvoiceOneView(),
    TodoView.routeName: (context) => const TodoView(),
    CreateTaskView.routeName: (context) => const CreateTaskView(),
    GenerateReport.routeName: (context) => const GenerateReport(),
    // ChangePassword.routeName: (context) => const ChangePassword(),

    // TransactionDetailsView.routeName: (context) =>
    //     const TransactionDetailsView(),
  };
  static Map<String, Widget Function(BuildContext)> get routes => _routes;
}
