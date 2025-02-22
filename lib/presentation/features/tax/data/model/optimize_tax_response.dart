class OptimizeTaxResponse {
  final bool? status;
  final OptimizedTax? optimizedTax;

  OptimizeTaxResponse({
    this.status,
    this.optimizedTax,
  });

  OptimizeTaxResponse copyWith({
    bool? status,
    OptimizedTax? optimizedTax,
  }) =>
      OptimizeTaxResponse(
        status: status ?? this.status,
        optimizedTax: optimizedTax ?? this.optimizedTax,
      );

  factory OptimizeTaxResponse.fromJson(Map<String, dynamic> json) =>
      OptimizeTaxResponse(
        status: json["status"],
        optimizedTax: json["optimized_tax"] == null
            ? null
            : OptimizedTax.fromJson(json["optimized_tax"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "optimized_tax": optimizedTax?.toJson(),
      };
}

class OptimizedTax {
  final List<String>? incomeManagementStrategy;
  final List<String>? maximizeDeductions;
  final List<String>? optimizeBusinessTaxes;

  OptimizedTax({
    this.incomeManagementStrategy,
    this.maximizeDeductions,
    this.optimizeBusinessTaxes,
  });

  OptimizedTax copyWith({
    List<String>? incomeManagementStrategy,
    List<String>? maximizeDeductions,
    List<String>? optimizeBusinessTaxes,
  }) =>
      OptimizedTax(
        incomeManagementStrategy:
            incomeManagementStrategy ?? this.incomeManagementStrategy,
        maximizeDeductions: maximizeDeductions ?? this.maximizeDeductions,
        optimizeBusinessTaxes:
            optimizeBusinessTaxes ?? this.optimizeBusinessTaxes,
      );

  factory OptimizedTax.fromJson(Map<String, dynamic> json) => OptimizedTax(
        incomeManagementStrategy: json["income management strategy"] == null
            ? []
            : List<String>.from(
                json["income management strategy"]!.map((x) => x)),
        maximizeDeductions: json["maximize deductions"] == null
            ? []
            : List<String>.from(json["maximize deductions"]!.map((x) => x)),
        optimizeBusinessTaxes: json["optimize business taxes"] == null
            ? []
            : List<String>.from(json["optimize business taxes"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "income management strategy": incomeManagementStrategy == null
            ? []
            : List<dynamic>.from(incomeManagementStrategy!.map((x) => x)),
        "maximize deductions": maximizeDeductions == null
            ? []
            : List<dynamic>.from(maximizeDeductions!.map((x) => x)),
        "optimize business taxes": optimizeBusinessTaxes == null
            ? []
            : List<dynamic>.from(optimizeBusinessTaxes!.map((x) => x)),
      };
}
