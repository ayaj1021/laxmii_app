import 'package:flutter/widgets.dart';
import 'package:laxmii_app/presentation/features/ai_chat/presentation/view/ai_assistant.dart';
import 'package:laxmii_app/presentation/features/ai_insights/presentation/view/ai_insights_view.dart';
import 'package:laxmii_app/presentation/features/dashboard/dashboard.dart';
import 'package:laxmii_app/presentation/features/expenses/presentation/view/expense_view.dart';
import 'package:laxmii_app/presentation/features/face_id_login/presentation/view/face_id_login_view.dart';
import 'package:laxmii_app/presentation/features/face_id_login/presentation/view/passcode_login_view.dart';
import 'package:laxmii_app/presentation/features/face_id_login/presentation/view/setup_pin_page.dart';
import 'package:laxmii_app/presentation/features/forgot_password/presentation/view/forgot_password.dart';
import 'package:laxmii_app/presentation/features/generate_report/presentation/view/generate_report.dart';
import 'package:laxmii_app/presentation/features/inventory/presentation/view/create_inventory_view.dart';
import 'package:laxmii_app/presentation/features/inventory/presentation/view/inventory_view.dart';
import 'package:laxmii_app/presentation/features/invoice/presentation/view/create_income_one_view.dart';
import 'package:laxmii_app/presentation/features/invoice/presentation/view/invoice_view.dart';
import 'package:laxmii_app/presentation/features/login/presentation/login_view.dart';
import 'package:laxmii_app/presentation/features/manage_account/presentation/view/manage_account_view.dart';
import 'package:laxmii_app/presentation/features/onboarding/presentation/view/onboarding_view.dart';
import 'package:laxmii_app/presentation/features/onboarding/presentation/view/welcome_screen.dart';
import 'package:laxmii_app/presentation/features/profile_setup/presentation/view/profile_setup_view.dart';
import 'package:laxmii_app/presentation/features/quotes/presentation/view/create_quote_view.dart';
import 'package:laxmii_app/presentation/features/quotes/presentation/view/quote_view.dart';
import 'package:laxmii_app/presentation/features/sign_up/presentation/view/sign_up_view.dart';
import 'package:laxmii_app/presentation/features/tax/presentation/view/tax_calculation_result.dart';
import 'package:laxmii_app/presentation/features/tax/presentation/view/tax_optimization_view.dart';
import 'package:laxmii_app/presentation/features/tax/presentation/view/tax_view.dart';
import 'package:laxmii_app/presentation/features/todo/presentation/view/create_task_view.dart';
import 'package:laxmii_app/presentation/features/todo/presentation/view/todo_view.dart';
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
    CreateExpenseView.routeName: (context) => const CreateExpenseView(),
    InvoiceView.routeName: (context) => const InvoiceView(),
    ExpenseView.routeName: (context) => const ExpenseView(),
    CreateIncomeOneView.routeName: (context) => const CreateIncomeOneView(),
    TodoView.routeName: (context) => const TodoView(),
    CreateTaskView.routeName: (context) => const CreateTaskView(),
    GenerateReport.routeName: (context) => const GenerateReport(),
    // AddNewInvoiceView.routeName: (context) => const AddNewInvoiceView(),
    QuoteView.routeName: (context) => const QuoteView(),
    CreateQuoteView.routeName: (context) => const CreateQuoteView(),
    //  AddItemSection.routeName: (context) => const AddItemSection(),
    TaxView.routeName: (context) => const TaxView(),
    TaxCalculationResult.routeName: (context) => const TaxCalculationResult(),
    TaxOptimizationView.routeName: (context) => const TaxOptimizationView(),
    AiAssistant.routeName: (context) => const AiAssistant(),
    // ChatView.routeName: (context) => const ChatView(),
    AiInsightsView.routeName: (context) => const AiInsightsView(),
    OnboardingView.routeName: (context) => const OnboardingView(),
    WelcomeScreen.routeName: (context) => const WelcomeScreen(),
    ProfileSetupView.routeName: (context) => const ProfileSetupView(),
    ManageAccountView.routeName: (context) => const ManageAccountView(),
    PasscodeLoginView.routeName: (context) => const PasscodeLoginView(),
    FaceIdLogin.routeName: (context) => const FaceIdLogin(),
    SetupPinPage.routeName: (context) => const SetupPinPage(),
  };
  static Map<String, Widget Function(BuildContext)> get routes => _routes;
}
