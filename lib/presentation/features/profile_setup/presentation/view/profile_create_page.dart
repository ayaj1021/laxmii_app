import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/get_access_token_notifier.dart';
import 'package:laxmii_app/presentation/general_widgets/custom_app_dropdown.dart';
import 'package:laxmii_app/presentation/general_widgets/laxmii_form_field.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

// ignore: must_be_immutable
class ProfileSetupPage extends ConsumerStatefulWidget {
  const ProfileSetupPage({
    super.key,
    required this.nameController,
    required this.selectedCountry,
    required this.selectedCurrency,
    required this.selectedIncomeType,
    required this.onCountryChanged,
    required this.onCurrencyChanged,
    required this.onIncomeTypeChanged,
  });

  final TextEditingController nameController;
  final String selectedCountry;
  final String selectedCurrency;
  final String selectedIncomeType;

  final ValueChanged<String> onCountryChanged;
  final ValueChanged<String> onCurrencyChanged;
  final ValueChanged<String> onIncomeTypeChanged;

  @override
  ConsumerState<ProfileSetupPage> createState() => _ProfileSetupPageState();
}

class _ProfileSetupPageState extends ConsumerState<ProfileSetupPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(getAccessTokenNotifier.notifier).accessToken();
    });
    super.initState();
  }

  String? selectedIncomeType;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Profile Setup',
          style: context.textTheme.s24w400.copyWith(
            color: colorScheme.colorScheme.onSurface,
          ),
        ),
        Text(
          'Let’s get your profile ready',
          style: context.textTheme.s14w400.copyWith(
            color: AppColors.primaryC4C4C4,
          ),
        ),
        const VerticalSpacing(42),
        LaxmiiFormfield(
          controller: widget.nameController,
          label: 'Full Name',
          labelSpace: 8,
          backgroundColor: Colors.transparent,
          bordercolor: AppColors.primary212121,
          hintText: 'Full name',
          hintStyle: context.textTheme.s14w400.copyWith(
              color: AppColors.primary212121, fontWeight: FontWeight.w300),
        ),
        const VerticalSpacing(16),
        CustomDropdown<String>(
          label: 'Country',
          items: countriesList.map((e) {
            return DropdownMenuItem<String>(
              value: e,
              child: Text(
                e,
                style: context.textTheme.s14w400.copyWith(
                  color: AppColors.primary5E5E5E,
                ),
              ),
            );
          }).toList(),
          hintText: 'Choose your country',
          value: widget.selectedCountry,
          onChanged: (String? value) {
            if (value != null) {
              widget.onCountryChanged(value);
            }
          },
        ),
        const VerticalSpacing(16),
        CustomDropdown<String>(
          label: 'Currency',
          items: countriesCurrency.map((e) {
            return DropdownMenuItem(
              value: e,
              child: Text(
                e,
                style: context.textTheme.s14w400.copyWith(
                  color: AppColors.primary5E5E5E,
                  fontSize: 18,
                ),
              ),
            );
          }).toList(),
          hintText: 'Choose your currency',
          value: widget.selectedCurrency,
          onChanged: (String? value) {
            if (value != null) {
              widget.onCurrencyChanged(value);
            }
          },
        ),
        const VerticalSpacing(16),
        CustomDropdown<String>(
          label: 'Income type',
          items: incomeType.map((e) {
            return DropdownMenuItem<String>(
              value: e,
              child: Text(
                e,
                style: context.textTheme.s14w400.copyWith(
                  color: AppColors.primary5E5E5E,
                  fontSize: 18,
                ),
              ),
            );
          }).toList(),
          hintText: 'Choose your income type',
          value: widget.selectedIncomeType,
          onChanged: (String? value) {
            if (value != null) {
              widget.onIncomeTypeChanged(value);
            }
          },
        ),
      ],
    );
  }
}

final List<String> countriesList = [
  'United Kingdom',
  'United States',
  'Others'
];

final List<String> countriesCurrency = ['£', '\$', '€'];
final List<String> incomeType = [
  'Individual',
  'Limited Company',
];
