import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/extensions/build_context_extension.dart';
import 'package:laxmii_app/core/extensions/overlay_extension.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/data/local_data_source/local_storage_impl.dart';
import 'package:laxmii_app/presentation/features/dashboard/dashboard.dart';
import 'package:laxmii_app/presentation/features/profile_setup/data/model/setup_profile_request.dart';
import 'package:laxmii_app/presentation/features/profile_setup/presentation/notifier/get_countries_notifier.dart';
import 'package:laxmii_app/presentation/features/profile_setup/presentation/notifier/select_financial_goals_notifier.dart';
import 'package:laxmii_app/presentation/features/profile_setup/presentation/notifier/set_up_profile_notifier.dart';
import 'package:laxmii_app/presentation/features/profile_setup/presentation/view/financial_goals_setup_view.dart';
import 'package:laxmii_app/presentation/features/profile_setup/presentation/view/profile_create_page.dart';
import 'package:laxmii_app/presentation/features/profile_setup/presentation/view/set_ai_preference_page.dart';
import 'package:laxmii_app/presentation/features/profile_setup/presentation/widgets/profile_setup_complete_dialog.dart';
import 'package:laxmii_app/presentation/features/profile_setup/presentation/widgets/progress_indicator_widget.dart';
import 'package:laxmii_app/presentation/general_widgets/app_outline_button.dart';
import 'package:laxmii_app/presentation/general_widgets/page_loader.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class ProfileSetupView extends ConsumerStatefulWidget {
  const ProfileSetupView({super.key});
  static const String routeName = '/profileSetup';

  @override
  ConsumerState<ProfileSetupView> createState() => _ProfileSetupViewState();
}

class _ProfileSetupViewState extends ConsumerState<ProfileSetupView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(getCountriesNotifier.notifier).getCountries();
    });
  }

  final ValueNotifier<bool> isProfileInputEnabled = ValueNotifier(false);
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final _nameController = TextEditingController();

  String? _selectedCountry = countriesList.first;
  String? _selectedCurrency = countriesCurrency.first;
  String? _selectedIncomeType = incomeType.first;

  void _validateInput() {
    isProfileInputEnabled.value = _nameController.text.isNotEmpty &&
        _selectedCountry != null &&
        _selectedCurrency != null &&
        _selectedIncomeType != null;
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(
      setupProfileNotifier.select((v) => v.setupProfileState.isLoading),
    );
    // final countryList =
    //     ref.watch(getCountriesNotifier.select((v) => v.data ?? []));
    return Scaffold(
      body: PageLoader(
        isLoading: isLoading,
        child: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 30),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ProgressIndicatorWidget(
                          isActive: _currentPage >= 0, color: Colors.amber),
                      const SizedBox(width: 8),
                      ProgressIndicatorWidget(
                          isActive: _currentPage >= 1, color: Colors.amber),
                      const SizedBox(width: 8),
                      ProgressIndicatorWidget(
                          isActive: _currentPage >= 2, color: Colors.amber),
                    ],
                  ),
                ),
                const VerticalSpacing(40),
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: PageView(
                      controller: _pageController,
                      children: [
                        ProfileSetupPage(
                          nameController: _nameController,
                          selectedCountry: _selectedCountry.toString(),
                          selectedCurrency: _selectedCurrency.toString(),
                          selectedIncomeType: _selectedIncomeType.toString(),
                          onCountryChanged: (value) {
                            setState(() {
                              _selectedCountry = value;
                              // _validateInput();
                            });
                          },
                          onCurrencyChanged: (value) {
                            setState(() {
                              _selectedCurrency = value;
                              _validateInput();
                            });
                          },
                          onIncomeTypeChanged: (value) {
                            setState(() {
                              _selectedIncomeType = value;
                              _validateInput();
                            });
                          },
                        ),
                        const FinancialGoalsSetupView(),
                        const SetAiPreferencePage(),
                      ],
                    )),
                const VerticalSpacing(50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: LaxmiiOutlineSendButton(
                          borderColor: _currentPage < 1
                              ? AppColors.primary262521
                              : AppColors.primaryColor,
                          onTap: () {
                            if (_currentPage > 0) {
                              // Go to the previous page in the PageView
                              setState(() {
                                _currentPage--;
                              });
                              _pageController.animateToPage(
                                _currentPage,
                                duration: const Duration(seconds: 1),
                                curve: Curves.easeInOut,
                              );
                            } else {
                              // Navigate back to the previous screen
                              Navigator.pop(context);
                            }
                          },
                          title: 'Back',
                          textColor: _currentPage < 1
                              ? AppColors.primary262521
                              : AppColors.primaryColor,
                        )),
                    ValueListenableBuilder<bool>(
                      valueListenable: isProfileInputEnabled,
                      builder: (context, isEnabled, child) {
                        return GestureDetector(
                          onTap: isEnabled
                              ? () {
                                  setState(() {
                                    _currentPage++;
                                    _currentPage == 1
                                        ? _pageController.animateToPage(
                                            _currentPage,
                                            duration:
                                                const Duration(milliseconds: 1),
                                            curve: Curves.easeInOut)
                                        : _currentPage == 2
                                            ? _pageController.animateToPage(
                                                _currentPage,
                                                duration: const Duration(
                                                    milliseconds: 1),
                                                curve: Curves.easeInOut)
                                            : _setUpProfile();
                                  });
                                }
                              : null,
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: isEnabled
                                  ? AppColors.primaryColor
                                  : AppColors.primary262521,
                              border: Border.all(
                                color: isEnabled
                                    ? AppColors.primaryColor
                                    : AppColors.primary262521,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  'Continue',
                                  style: context.textTheme.s14w400.copyWith(
                                    color: AppColors.primaryC4C4C4,
                                  ),
                                ),
                                const Icon(
                                  Icons.arrow_forward,
                                  color: AppColors.white,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        )),
      ),
    );
  }

  void _setUpProfile() async {
    final checkboxState = ref.read(checkboxStateProvider);

    await AppDataStorage().saveUserCurrency(_selectedCurrency.toString());
    final data = SetupUpProfileRequest(
      fullName: _nameController.text.trim(),
      country: _selectedCountry.toString(),
      currency: _selectedCurrency.toString(),
      incomeType: _selectedIncomeType.toString(),
      financialGoals: FinancialGoals(
        increaseSavings: checkboxState['increaseSavings'] ?? false,
        reduceExpenses: checkboxState['reduceExpenses'] ?? false,
        optimizeTaxDeductions: checkboxState['optimizeTaxDeductions'] ?? false,
        trackBusinessIncome: checkboxState['trackBusinessIncome'] ?? false,
        investSmarter: checkboxState['investSmarter'] ?? false,
      ),
      aiPreferences: AiPreferences(
        budgetAlerts: checkboxState['budgetAlerts'] ?? false,
        taxSavings: checkboxState['taxSavings'] ?? false,
        investmentTips: checkboxState['investmentTips'] ?? false,
      ),
    );

    ref.read(setupProfileNotifier.notifier).setupProfile(
          data: data,
          onError: (error) {
            context.showError(message: error);
          },
          onSuccess: (message) {
            context.hideOverLay();
            context.showSuccess(message: message);
            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                      contentPadding: EdgeInsets.zero,
                      content: ProfileSetupCompleteAlertDialog(
                        message: message,
                        onTap: () =>
                            context.pushReplacementNamed(Dashboard.routeName),
                      ),
                    ));
          },
        );
  }
}
