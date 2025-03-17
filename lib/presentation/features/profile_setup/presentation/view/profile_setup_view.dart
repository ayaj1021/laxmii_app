import 'package:flutter/material.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/features/profile_setup/presentation/view/financial_goals_setup_view.dart';
import 'package:laxmii_app/presentation/features/profile_setup/presentation/view/profile_create_page.dart';
import 'package:laxmii_app/presentation/features/profile_setup/presentation/widgets/progress_indicator_widget.dart';
import 'package:laxmii_app/presentation/general_widgets/app_outline_button.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class ProfileSetupView extends StatefulWidget {
  const ProfileSetupView({super.key});
  static const String routeName = '/profileSetup';

  @override
  State<ProfileSetupView> createState() => _ProfileSetupViewState();
}

class _ProfileSetupViewState extends State<ProfileSetupView> {
  final ValueNotifier<bool> isProfileInputEnabled = ValueNotifier(false);
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final _emailController = TextEditingController();

  String? _selectedCountry = countriesList.first;
  String? _selectedCurrency = countriesCurrency.first;
  String? _selectedIncomeType = incomeType.first;

  void _validateInput() {
    isProfileInputEnabled.value = _emailController.text.isNotEmpty &&
        _selectedCountry != null &&
        _selectedCurrency != null &&
        _selectedIncomeType != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                        emailController: _emailController,
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
                      const FinancialGoalsSetupView(
                        increaseSavingsBool: true,
                      ),
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
                              duration: const Duration(milliseconds: 300),
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
                  // GestureDetector(
                  //   onTap: () {
                  //     setState(() {
                  //       _currentPage++;
                  //       _currentPage == 1
                  //           ? _pageController.animateToPage(_currentPage,
                  //               duration: const Duration(seconds: 1),
                  //               curve: Curves.easeInOut)
                  //           : null;
                  //     });
                  //   },
                  //   child: Container(
                  //     padding: const EdgeInsets.all(12),
                  //     decoration: BoxDecoration(
                  //         color: AppColors.primaryColor,
                  //         border: Border.all(
                  //           color: _currentPage < 1
                  //               ? AppColors.primary262521
                  //               : AppColors.primaryColor,
                  //         ),
                  //         borderRadius: BorderRadius.circular(10)),
                  //     child: Row(
                  //       children: [
                  //         Text(
                  //           'Continue',
                  //           style: context.textTheme.s14w400.copyWith(
                  //             color: AppColors.primaryC4C4C4,
                  //           ),
                  //         ),
                  //         const Icon(
                  //           Icons.arrow_forward,
                  //           color: AppColors.white,
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),

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
                                          duration: const Duration(seconds: 1),
                                          curve: Curves.easeInOut)
                                      : null;
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
    );
  }
}
