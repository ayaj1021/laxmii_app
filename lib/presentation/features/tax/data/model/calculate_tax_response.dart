class CalculateTaxResponse {
  final bool? status;
  final TaxCalculation? taxCalculation;

  CalculateTaxResponse({
    this.status,
    this.taxCalculation,
  });

  CalculateTaxResponse copyWith({
    bool? status,
    TaxCalculation? taxCalculation,
  }) =>
      CalculateTaxResponse(
        status: status ?? this.status,
        taxCalculation: taxCalculation ?? this.taxCalculation,
      );

  factory CalculateTaxResponse.fromJson(Map<String, dynamic> json) =>
      CalculateTaxResponse(
        status: json["status"],
        taxCalculation: json["taxCalculation"] == null
            ? null
            : TaxCalculation.fromJson(json["taxCalculation"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "taxCalculation": taxCalculation?.toJson(),
      };
}

class TaxCalculation {
  final num? totalIncome;
  final num? personalAllowance;
  final num? taxableIncome;
  final num? incomeTaxDue;
  final num? niDue;
  final num? totalTax;
  final num? afterTaxIncome;
  final String? effectiveTaxRate;

  TaxCalculation({
    this.totalIncome,
    this.personalAllowance,
    this.taxableIncome,
    this.incomeTaxDue,
    this.niDue,
    this.totalTax,
    this.afterTaxIncome,
    this.effectiveTaxRate,
  });

  TaxCalculation copyWith({
    num? totalIncome,
    num? personalAllowance,
    num? taxableIncome,
    num? incomeTaxDue,
    num? niDue,
    num? totalTax,
    num? afterTaxIncome,
    String? effectiveTaxRate,
  }) =>
      TaxCalculation(
        totalIncome: totalIncome ?? this.totalIncome,
        personalAllowance: personalAllowance ?? this.personalAllowance,
        taxableIncome: taxableIncome ?? this.taxableIncome,
        incomeTaxDue: incomeTaxDue ?? this.incomeTaxDue,
        niDue: niDue ?? this.niDue,
        totalTax: totalTax ?? this.totalTax,
        afterTaxIncome: afterTaxIncome ?? this.afterTaxIncome,
        effectiveTaxRate: effectiveTaxRate ?? this.effectiveTaxRate,
      );

  factory TaxCalculation.fromJson(Map<String, dynamic> json) => TaxCalculation(
        totalIncome: json["totalIncome"],
        personalAllowance: json["personalAllowance"],
        taxableIncome: json["taxableIncome"],
        incomeTaxDue: json["incomeTaxDue"],
        niDue: json["niDue"],
        totalTax: json["totalTax"],
        afterTaxIncome: json["afterTaxIncome"],
        effectiveTaxRate: json["effectiveTaxRate"],
      );

  Map<String, dynamic> toJson() => {
        "totalIncome": totalIncome,
        "personalAllowance": personalAllowance,
        "taxableIncome": taxableIncome,
        "incomeTaxDue": incomeTaxDue,
        "niDue": niDue,
        "totalTax": totalTax,
        "afterTaxIncome": afterTaxIncome,
        "effectiveTaxRate": effectiveTaxRate,
      };
}
