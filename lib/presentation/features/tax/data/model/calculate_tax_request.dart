class CalculateTaxRequest {
  final String period;
  final int profit;

  CalculateTaxRequest({
    required this.period,
    required this.profit,
  });

  CalculateTaxRequest copyWith({
    String? period,
    int? profit,
  }) =>
      CalculateTaxRequest(
        period: period ?? this.period,
        profit: profit ?? this.profit,
      );

  factory CalculateTaxRequest.fromJson(Map<String, dynamic> json) =>
      CalculateTaxRequest(
        period: json["period"],
        profit: json["profit"],
      );

  Map<String, dynamic> toJson() => {
        "period": period,
        "profit": profit,
      };
}
