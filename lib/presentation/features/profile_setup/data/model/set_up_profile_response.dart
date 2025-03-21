class SetupUpProfileResponse {
  final bool? status;
  final String? message;
  final SavedProfile? savedProfile;

  SetupUpProfileResponse({
    this.status,
    this.message,
    this.savedProfile,
  });

  SetupUpProfileResponse copyWith({
    bool? status,
    String? message,
    SavedProfile? savedProfile,
  }) =>
      SetupUpProfileResponse(
        status: status ?? this.status,
        message: message ?? this.message,
        savedProfile: savedProfile ?? this.savedProfile,
      );

  factory SetupUpProfileResponse.fromJson(Map<String, dynamic> json) =>
      SetupUpProfileResponse(
        status: json["status"],
        message: json["message"],
        savedProfile: json["savedProfile"] == null
            ? null
            : SavedProfile.fromJson(json["savedProfile"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "savedProfile": savedProfile?.toJson(),
      };
}

class SavedProfile {
  final String? user;
  final String? fullName;
  final String? country;
  final String? currency;
  final String? incomeType;
  final FinancialGoals? financialGoals;
  final AiPreferences? aiPreferences;
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  SavedProfile({
    this.user,
    this.fullName,
    this.country,
    this.currency,
    this.incomeType,
    this.financialGoals,
    this.aiPreferences,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  SavedProfile copyWith({
    String? user,
    String? fullName,
    String? country,
    String? currency,
    String? incomeType,
    FinancialGoals? financialGoals,
    AiPreferences? aiPreferences,
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) =>
      SavedProfile(
        user: user ?? this.user,
        fullName: fullName ?? this.fullName,
        country: country ?? this.country,
        currency: currency ?? this.currency,
        incomeType: incomeType ?? this.incomeType,
        financialGoals: financialGoals ?? this.financialGoals,
        aiPreferences: aiPreferences ?? this.aiPreferences,
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );

  factory SavedProfile.fromJson(Map<String, dynamic> json) => SavedProfile(
        user: json["user"],
        fullName: json["fullName"],
        country: json["country"],
        currency: json["currency"],
        incomeType: json["incomeType"],
        financialGoals: json["financialGoals"] == null
            ? null
            : FinancialGoals.fromJson(json["financialGoals"]),
        aiPreferences: json["aiPreferences"] == null
            ? null
            : AiPreferences.fromJson(json["aiPreferences"]),
        id: json["_id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "fullName": fullName,
        "country": country,
        "currency": currency,
        "incomeType": incomeType,
        "financialGoals": financialGoals?.toJson(),
        "aiPreferences": aiPreferences?.toJson(),
        "_id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class AiPreferences {
  final bool? budgetAlerts;
  final bool? taxSavings;
  final bool? investmentTips;

  AiPreferences({
    this.budgetAlerts,
    this.taxSavings,
    this.investmentTips,
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
  final bool? increaseSavings;
  final bool? reduceExpenses;
  final bool? optimizeTaxDeductions;
  final bool? trackBusinessIncome;
  final bool? investSmarter;

  FinancialGoals({
    this.increaseSavings,
    this.reduceExpenses,
    this.optimizeTaxDeductions,
    this.trackBusinessIncome,
    this.investSmarter,
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
