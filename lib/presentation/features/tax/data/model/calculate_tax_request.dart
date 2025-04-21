class CalculateTaxRequest {
  final String period;
  final String type;
  final num profit;

  CalculateTaxRequest({
    required this.period,
    required this.type,
    required this.profit,
  });

  CalculateTaxRequest copyWith({
    String? period,
    String? type,
    num? profit,
  }) =>
      CalculateTaxRequest(
        period: period ?? this.period,
        type: type ?? this.type,
        profit: profit ?? this.profit,
      );

  factory CalculateTaxRequest.fromJson(Map<String, dynamic> json) =>
      CalculateTaxRequest(
        period: json["period"],
        type: json["type"],
        profit: json["profit"],
      );

  Map<String, dynamic> toJson() => {
        "period": period,
        "type": type,
        "profit": profit,
      };
}
