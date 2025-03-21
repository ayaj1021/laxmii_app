class SetupUpProfileRequest {
  final String fullName;
  final String country;
  final String currency;
  final String incomeType;
  final FinancialGoals financialGoals;
  final AiPreferences aiPreferences;

  SetupUpProfileRequest({
    required this.fullName,
    required this.country,
    required this.currency,
    required this.incomeType,
    required this.financialGoals,
    required this.aiPreferences,
  });

  SetupUpProfileRequest copyWith({
    String? fullName,
    String? country,
    String? currency,
    String? incomeType,
    FinancialGoals? financialGoals,
    AiPreferences? aiPreferences,
  }) =>
      SetupUpProfileRequest(
        fullName: fullName ?? this.fullName,
        country: country ?? this.country,
        currency: currency ?? this.currency,
        incomeType: incomeType ?? this.incomeType,
        financialGoals: financialGoals ?? this.financialGoals,
        aiPreferences: aiPreferences ?? this.aiPreferences,
      );

  factory SetupUpProfileRequest.fromJson(Map<String, dynamic> json) =>
      SetupUpProfileRequest(
        fullName: json["fullName"],
        country: json["country"],
        currency: json["currency"],
        incomeType: json["incomeType"],
        financialGoals: FinancialGoals.fromJson(json["financialGoals"]),
        aiPreferences: AiPreferences.fromJson(json["aiPreferences"]),
      );

  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "country": country,
        "currency": currency,
        "incomeType": incomeType,
        "financialGoals": financialGoals.toJson(),
        "aiPreferences": aiPreferences.toJson(),
      };
}

class AiPreferences {
  final bool budgetAlerts;
  final bool taxSavings;
  final bool investmentTips;

  AiPreferences({
    required this.budgetAlerts,
    required this.taxSavings,
    required this.investmentTips,
  });

  AiPreferences copyWith({
    bool? budgetAlerts,
    bool? taxSavings,
    bool? investmentTips,
  }) =>
      AiPreferences(
        budgetAlerts: budgetAlerts ?? this.budgetAlerts,
        taxSavings: taxSavings ?? this.taxSavings,
        investmentTips: investmentTips ?? this.investmentTips,
      );

  factory AiPreferences.fromJson(Map<String, dynamic> json) => AiPreferences(
        budgetAlerts: json["budgetAlerts"],
        taxSavings: json["taxSavings"],
        investmentTips: json["investmentTips"],
      );

  Map<String, dynamic> toJson() => {
        "budgetAlerts": budgetAlerts,
        "taxSavings": taxSavings,
        "investmentTips": investmentTips,
      };
}

class FinancialGoals {
  final bool increaseSavings;
  final bool reduceExpenses;
  final bool optimizeTaxDeductions;
  final bool trackBusinessIncome;
  final bool investSmarter;

  FinancialGoals({
    required this.increaseSavings,
    required this.reduceExpenses,
    required this.optimizeTaxDeductions,
    required this.trackBusinessIncome,
    required this.investSmarter,
  });

  FinancialGoals copyWith({
    bool? increaseSavings,
    bool? reduceExpenses,
    bool? optimizeTaxDeductions,
    bool? trackBusinessIncome,
    bool? investSmarter,
  }) =>
      FinancialGoals(
        increaseSavings: increaseSavings ?? this.increaseSavings,
        reduceExpenses: reduceExpenses ?? this.reduceExpenses,
        optimizeTaxDeductions:
            optimizeTaxDeductions ?? this.optimizeTaxDeductions,
        trackBusinessIncome: trackBusinessIncome ?? this.trackBusinessIncome,
        investSmarter: investSmarter ?? this.investSmarter,
      );

  factory FinancialGoals.fromJson(Map<String, dynamic> json) => FinancialGoals(
        increaseSavings: json["increaseSavings"],
        reduceExpenses: json["reduceExpenses"],
        optimizeTaxDeductions: json["optimizeTaxDeductions"],
        trackBusinessIncome: json["trackBusinessIncome"],
        investSmarter: json["investSmarter"],
      );

  Map<String, dynamic> toJson() => {
        "increaseSavings": increaseSavings,
        "reduceExpenses": reduceExpenses,
        "optimizeTaxDeductions": optimizeTaxDeductions,
        "trackBusinessIncome": trackBusinessIncome,
        "investSmarter": investSmarter,
      };
}
