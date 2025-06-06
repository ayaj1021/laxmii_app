class UpdateProfileResponse {
  final bool? status;
  final String? message;
  final Profile? profile;

  UpdateProfileResponse({
    this.status,
    this.message,
    this.profile,
  });

  UpdateProfileResponse copyWith({
    bool? status,
    String? message,
    Profile? profile,
  }) =>
      UpdateProfileResponse(
        status: status ?? this.status,
        message: message ?? this.message,
        profile: profile ?? this.profile,
      );

  factory UpdateProfileResponse.fromJson(Map<String, dynamic> json) =>
      UpdateProfileResponse(
        status: json["status"],
        message: json["message"],
        profile:
            json["profile"] == null ? null : Profile.fromJson(json["profile"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "profile": profile?.toJson(),
      };
}

class Profile {
  final FinancialGoals? financialGoals;
  final AiPreferences? aiPreferences;
  final String? id;
  final String? user;
  final String? fullName;
  final String? country;
  final String? currency;
  final String? incomeType;
  final dynamic profilePicture;
  final String? businessName;
  final String? address;
  final String? phoneNumber;
  final String? accountName;
  final String? accountNumber;
  final String? bankName;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  Profile({
    this.financialGoals,
    this.aiPreferences,
    this.id,
    this.user,
    this.fullName,
    this.country,
    this.currency,
    this.incomeType,
    this.profilePicture,
    this.businessName,
    this.address,
    this.phoneNumber,
    this.accountName,
    this.accountNumber,
    this.bankName,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  Profile copyWith({
    FinancialGoals? financialGoals,
    AiPreferences? aiPreferences,
    String? id,
    String? user,
    String? fullName,
    String? country,
    String? currency,
    String? incomeType,
    dynamic profilePicture,
    String? businessName,
    String? address,
    String? phoneNumber,
    String? accountName,
    String? accountNumber,
    String? bankName,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) =>
      Profile(
        financialGoals: financialGoals ?? this.financialGoals,
        aiPreferences: aiPreferences ?? this.aiPreferences,
        id: id ?? this.id,
        user: user ?? this.user,
        fullName: fullName ?? this.fullName,
        country: country ?? this.country,
        currency: currency ?? this.currency,
        incomeType: incomeType ?? this.incomeType,
        profilePicture: profilePicture ?? this.profilePicture,
        businessName: businessName ?? this.businessName,
        address: address ?? this.address,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        accountName: accountName ?? this.accountName,
        accountNumber: accountNumber ?? this.accountNumber,
        bankName: bankName ?? this.bankName,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        financialGoals: json["financialGoals"] == null
            ? null
            : FinancialGoals.fromJson(json["financialGoals"]),
        aiPreferences: json["aiPreferences"] == null
            ? null
            : AiPreferences.fromJson(json["aiPreferences"]),
        id: json["_id"],
        user: json["user"],
        fullName: json["fullName"],
        country: json["country"],
        currency: json["currency"],
        incomeType: json["incomeType"],
        profilePicture: json["profilePicture"],
        businessName: json["businessName"],
        address: json["address"],
        phoneNumber: json["phoneNumber"],
        accountName: json["accountName"],
        accountNumber: json["accountNumber"],
        bankName: json["bankName"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "financialGoals": financialGoals?.toJson(),
        "aiPreferences": aiPreferences?.toJson(),
        "_id": id,
        "user": user,
        "fullName": fullName,
        "country": country,
        "currency": currency,
        "incomeType": incomeType,
        "profilePicture": profilePicture,
        "businessName": businessName,
        "address": address,
        "phoneNumber": phoneNumber,
        "accountName": accountName,
        "accountNumber": accountNumber,
        "bankName": bankName,
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
