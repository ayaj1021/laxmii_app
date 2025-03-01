class OptimizeTaxRequest {
  final num totalIncome;
  final num personalAllowance;
  final num taxableIncome;
  final String incomeTaxDue;
  final String niDue;
  final String totalTax;
  final String afterTaxIncome;
  final String effectiveTaxRate;

  OptimizeTaxRequest({
    required this.totalIncome,
    required this.personalAllowance,
    required this.taxableIncome,
    required this.incomeTaxDue,
    required this.niDue,
    required this.totalTax,
    required this.afterTaxIncome,
    required this.effectiveTaxRate,
  });

  OptimizeTaxRequest copyWith({
    num? totalIncome,
    num? personalAllowance,
    num? taxableIncome,
    String? incomeTaxDue,
    String? niDue,
    String? totalTax,
    String? afterTaxIncome,
    String? effectiveTaxRate,
  }) =>
      OptimizeTaxRequest(
        totalIncome: totalIncome ?? this.totalIncome,
        personalAllowance: personalAllowance ?? this.personalAllowance,
        taxableIncome: taxableIncome ?? this.taxableIncome,
        incomeTaxDue: incomeTaxDue ?? this.incomeTaxDue,
        niDue: niDue ?? this.niDue,
        totalTax: totalTax ?? this.totalTax,
        afterTaxIncome: afterTaxIncome ?? this.afterTaxIncome,
        effectiveTaxRate: effectiveTaxRate ?? this.effectiveTaxRate,
      );

  factory OptimizeTaxRequest.fromJson(Map<String, dynamic> json) =>
      OptimizeTaxRequest(
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
